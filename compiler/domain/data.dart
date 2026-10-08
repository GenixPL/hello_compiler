sealed class const Data<T>({
  required final String ref,
  required final T data,
}) {
  static int _counter = 0;

  static String getNextRef() {
    return 'd_${_counter++}';
  }

  List<String> get assembly;
}

class StringData({
  required super.ref,
  required super.data,
}) extends Data<String> {
  @override
  List<String> get assembly => [
    '.asciz "$data"',
    // Give it space for 50 chars.
    '.space  50 - (. - $ref), 0',
  ];
}

class IntData({
  required super.ref,
  required super.data,
}) extends Data<int> {
  @override
  List<String> get assembly => [
    '.word $data',
  ];
}
