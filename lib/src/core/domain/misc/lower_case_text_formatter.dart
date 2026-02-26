import 'package:flutter/services.dart';

final class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) => TextEditingValue(
    text: newValue.text.toLowerCase(),
    selection: newValue.selection,
  );
}
