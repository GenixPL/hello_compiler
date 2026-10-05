import 'command.dart';

class IntToStrCommand({
  required final String dataRef,
}) implements Command {
  @override
  List<String> get assemblyLines {
    return [
      'adrp x0, $dataRef@PAGE',
      'add x0, x0, $dataRef@PAGEOFF',
      'bl int_to_str',
    ];
  }
}
