abstract interface class RegexUtil {
  static final onlyNumbers = RegExp(r'[^0-9]');
  static final nameChars = RegExp('[a-zA-ZÀ-ÿçÇ 0-9]');
}
