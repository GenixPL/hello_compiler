String betweenBrackets(String string) {
  final int start = string.indexOf('(');
  final int end = string.lastIndexOf(')');
  return string.substring(
    // + (
    // '
    start + 2,
    // - '
    end - 1,
  );
}
