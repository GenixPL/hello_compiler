sealed class const Data<T>({
  required final String ref,
  required final T data,
}) {
  static int _counter = 0;

  static String getNextRef() {
    return 'd_${_counter++}';
  }
}

class StringData({
  required super.ref,
  required super.data,
}) extends Data<String>;

class IntData({
  required super.ref,
  required super.data,
}) extends Data<String>;
