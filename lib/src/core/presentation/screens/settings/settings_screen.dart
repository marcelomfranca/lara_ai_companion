import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../application/controllers/lara_config_controller.dart';
import '../../../application/extensions/async_value_extension.dart';
import '../../../application/extensions/hardcoded_string_extension.dart';
import '../../../application/extensions/theme_build_context_extension.dart';
import '../../../application/validators/special_unicode_char_validator.dart';
import '../../../domain/misc/regex_util.dart';
import '../../controllers/theme_controller.dart';
import '../../widgets/buttons/ink_well_no_style_button.dart';
import '../../widgets/cards/card_widget.dart';
import '../../../../features/ai/domain/enums/ai_response_length_enum.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen>
    with AutomaticKeepAliveClientMixin {
  late final _config = ref
      .read(laraConfigControllerProvider.notifier)
      .laraConfig;
  final _languageController = TextEditingController();
  var hasLanguageChanged = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _languageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ref.listen<AsyncValue<void>>(
      laraConfigControllerProvider,
      (_, state) => state.showSnackBarOnError(context),
    );

    final configState = ref.watch(laraConfigControllerProvider);
    final config = configState.asData?.value ?? _config;
    final controller = ref.read(laraConfigControllerProvider.notifier);

    final humorLevel = (config.humorLevel * 100).floor();
    // final language = config.language;
    final responseLength = config.responseLength;

    if (_languageController.text.isNotEmpty) {
      hasLanguageChanged = (_languageController.text != config.language)
          ? true
          : false;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _languageController.text = config.language;

      hasLanguageChanged = (_languageController.text != config.language)
          ? true
          : false;
    });

    final themeController = ref.read(themeControllerProvider.notifier);
    final themeState = ref.watch(themeControllerProvider);
    final themeMode =
        themeState.asData?.value.mode ??
        ref.read(themeControllerProvider.notifier).themeState.mode;
    final themeModeValue = (themeMode == ThemeMode.dark) ? true : false;
    final isDarkMode = (themeMode == ThemeMode.dark);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 16),
                  CardWidget(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              'LARA Settings'.hardcoded,
                              style: context.textStyles.text14Bold,
                            ),
                            const SizedBox(height: 16),
                            Column(
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Humor / Personality Tone'.hardcoded,
                                          style: context.textStyles.text12w600,
                                        ),
                                        Text(
                                          '$humorLevel%'.hardcoded,
                                          style: context.textStyles.text12w500
                                              .copyWith(
                                                color: context
                                                    .colors
                                                    .titaniumEcho
                                                    .withValues(alpha: 0.6),
                                              ),
                                        ),
                                      ],
                                    ),
                                    Slider(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      value: config.humorLevel,
                                      max: 1.0,
                                      onChanged: (double value) {
                                        controller.updateConfig(
                                          humorLevel: value,
                                        );
                                      },
                                    ),
                                    Text(
                                      'Adjust how LARA communicates with you'
                                          .hardcoded,
                                      style: context.textStyles.text10w500
                                          .copyWith(
                                            color: context.colors.titaniumEcho,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Column(
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Response Length'.hardcoded,
                                      style: context.textStyles.text12w600,
                                    ),
                                    RadioGroup<AiResponseLengthEnum>(
                                      groupValue: responseLength,
                                      onChanged: (value) {
                                        controller.updateConfig(
                                          responseLength: value,
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Radio<AiResponseLengthEnum>(
                                                key: ValueKey(
                                                  AiResponseLengthEnum.short,
                                                ),
                                                value:
                                                    AiResponseLengthEnum.short,
                                              ),
                                              Text(
                                                'Short'.hardcoded,
                                                style: context
                                                    .textStyles
                                                    .text12w600,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Radio<AiResponseLengthEnum>(
                                                key: ValueKey(
                                                  AiResponseLengthEnum.medium,
                                                ),
                                                value:
                                                    AiResponseLengthEnum.medium,
                                              ),
                                              Text(
                                                'Medium'.hardcoded,
                                                style: context
                                                    .textStyles
                                                    .text12w600,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Radio<AiResponseLengthEnum>(
                                                key: ValueKey(
                                                  AiResponseLengthEnum.long,
                                                ),
                                                value:
                                                    AiResponseLengthEnum.long,
                                              ),
                                              Text(
                                                'Long'.hardcoded,
                                                style: context
                                                    .textStyles
                                                    .text12w600,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'Preferred length of LARA`s responses'
                                          .hardcoded,
                                      style: context.textStyles.text10w500
                                          .copyWith(
                                            color: context.colors.titaniumEcho,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Language'.hardcoded,
                                  style: context.textStyles.text12w600,
                                ),
                                const SizedBox(height: 16),
                                ValueListenableBuilder<TextEditingValue>(
                                  valueListenable: _languageController,
                                  builder: (context, value, child) {
                                    var currentState = value.text.trim();

                                    if (currentState.isNotEmpty) {
                                      hasLanguageChanged =
                                          (currentState != config.language)
                                          ? true
                                          : false;
                                    }

                                    return TextFormField(
                                      key: const ValueKey('settings_lang'),
                                      controller: _languageController,
                                      maxLength: 40,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegexUtil.nameChars,
                                        ),
                                        FilteringTextInputFormatter.deny(
                                          SpecialUnicodeCharValidator().regex,
                                        ),
                                      ],
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      decoration: context.decorations.textField
                                          .copyWith(
                                            hintText: 'English',
                                            counterText: '',
                                            contentPadding:
                                                const EdgeInsets.all(10),
                                            suffixIcon: hasLanguageChanged
                                                ? TextButton(
                                                    onPressed: () {
                                                      if (_languageController
                                                          .text
                                                          .isNotEmpty) {
                                                        controller.updateConfig(
                                                          language:
                                                              _languageController
                                                                  .text
                                                                  .trim(),
                                                        );
                                                      }
                                                    },
                                                    child: Text(
                                                      'salvar'.hardcoded,
                                                      style: context
                                                          .textStyles
                                                          .text12w500,
                                                    ),
                                                  )
                                                : null,
                                          ),
                                      keyboardType: TextInputType.text,
                                    );
                                  },
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'What language do you prefer for LARA to respond?'
                                      .hardcoded,
                                  style: context.textStyles.text10w500.copyWith(
                                    color: context.colors.titaniumEcho,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                      .animate(delay: 0.3.ms)
                      .fadeIn(
                        begin: 0,
                        duration: 300.ms,
                        curve: Curves.easeInOut,
                      ),
                  const SizedBox(height: 16),
                  CardWidget(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              'App Settings'.hardcoded,
                              style: context.textStyles.text14Bold,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  isDarkMode
                                      ? Icons.light_mode_outlined
                                      : Icons.nightlight_outlined,
                                  color: context.colors.titaniumEcho,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      isDarkMode
                                          ? 'Light Mode'.hardcoded
                                          : 'Dark Mode'.hardcoded,
                                      style: context.textStyles.text12w600,
                                    ),
                                    Text(
                                      'Switch between light and dark theme'
                                          .hardcoded,
                                      style: context.textStyles.text10w500
                                          .copyWith(
                                            color: context.colors.titaniumEcho,
                                          ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                SizedBox(
                                  width: 30,
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Switch(
                                      value: themeModeValue,
                                      onChanged: (bool value) {
                                        themeController.toggleThemeMode(value);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            InkWellNoStyleButton(
                              color: context.colors.darkGrey.withValues(
                                alpha: 0.6,
                              ),
                              onTap: () => context.push('/about'),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      Icons.info_outline_rounded,
                                      color: context.colors.titaniumEcho,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'About'.hardcoded,
                                          style: context.textStyles.text12w600,
                                        ),
                                        Text(
                                          'App version and information'
                                              .hardcoded,
                                          style: context.textStyles.text10w500
                                              .copyWith(
                                                color:
                                                    context.colors.titaniumEcho,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(Icons.arrow_forward),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate(delay: 0.6.ms)
                      .fadeIn(
                        begin: 0,
                        duration: 300.ms,
                        curve: Curves.easeInOut,
                      ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
