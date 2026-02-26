import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/domain/enums/form_validator_mode.dart';
import '../../../../core/application/extensions/hardcoded_string_extension.dart';
import '../../../../core/application/extensions/theme_build_context_extension.dart';
import '../../../../core/domain/exceptions/validator_exception.dart';
import '../../../../core/domain/misc/string_validator.dart';
import '../../../../core/presentation/widgets/buttons/lock_icon_button.dart';
import '../../../../core/presentation/widgets/buttons/lock_open_icon_button.dart';
import '../../../../core/presentation/widgets/prefix_icon_container.dart';
import 'error_text.dart';
import 'form_title.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    super.key,
    this.title,
    this.controller,
    this.confirmController,
    this.hintText,
    this.validator,
    this.onChanged,
    this.onTap,
    this.onTapOutside,
    this.validators,
    this.validatorMode = FormValidatorMode.all,
    this.inputFormatters,
  });

  final String? title;
  final String? hintText;
  final TextEditingController? controller;
  final TextEditingController? confirmController;
  final void Function(String, String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final List<StringValidator>? validators;
  final FormValidatorMode validatorMode;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<PasswordFormField> createState() => PasswordFormFieldState();
}

class PasswordFormFieldState extends State<PasswordFormField> {
  late final controller = widget.controller ?? TextEditingController();
  bool obscureText = true;
  late Color indicatorColor = context.colors.border;
  late var errorText = List.filled((widget.validators?.length ?? 0) + 1, '');

  bool _errorIsEmpty() => errorText.every((element) => element.isEmpty);

  bool validate() {
    final validated = _validator(controller.text);

    if (mounted) {
      if (validated) {
        setState(() {
          indicatorColor = context.colors.border;
        });
      } else {
        setState(() {
          indicatorColor = context.colors.primary;
        });
      }
    }

    return validated;
  }

  bool _validator(String value) {
    if (widget.validator != null) {
      try {
        widget.validator!.call(value, widget.confirmController?.text ?? '');
        errorText[0] = '';
      } on ValidatorException catch (e) {
        errorText[0] = e.message;
      }
    } else if (widget.validators != null) {
      for (var i = 0; i < widget.validators!.length; i++) {
        final validator = widget.validators![i];

        try {
          validator.isValid(value);
          errorText[i] = '';
        } on ValidatorException catch (e) {
          errorText[i] = e.message;
        }
      }
    }

    return _errorIsEmpty();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[FormTitle(text: widget.title!)],
        TextFormField(
          textCapitalization: TextCapitalization.sentences,
          controller: widget.controller,
          obscureText: obscureText,
          scrollPadding: EdgeInsets.zero,
          style: context.textStyles.text16.copyWith(
            color: (!_errorIsEmpty()) ? indicatorColor : null,
          ),
          autovalidateMode: AutovalidateMode.disabled,
          cursorColor: indicatorColor,
          obscuringCharacter: '●',
          inputFormatters: widget.inputFormatters,
          decoration: context.decorations.textField.copyWith(
            hintText: widget.hintText ?? 'Enter your password'.hardcoded,
            hintStyle: context.textStyles.text16.copyWith(
              color: context.colors.hintText,
            ),
            prefixIcon: PrefixIconContainer(
              child: obscureText
                  ? LockIconButton(
                      onTap: () => setState(() => obscureText = !obscureText),
                    )
                  : LockOpenIconButton(
                      onTap: () => setState(() => obscureText = !obscureText),
                    ),
            ),
          ),
          onTap: widget.onTap,
          onTapOutside: widget.onTapOutside,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }

            validate();
          },
          validator: (value) {
            final validated = validate();

            return validated ? null : '';
          },
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ...List<Widget>.generate(
              errorText.length,
              (index) => ErrorText(text: errorText[index]),
            ),
          ],
        ),
      ],
    );
  }
}
