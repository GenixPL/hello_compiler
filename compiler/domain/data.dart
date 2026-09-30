class const Data({
  required final String ref,
  required final String data,
}) {
  static int _counter = 0;

  static String getNextRef() {
    return 'd_${_counter++}';
  }
}
