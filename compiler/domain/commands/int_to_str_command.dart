import 'command.dart';

class IntToStrCommand({
  required final String dataRef,
  required final String outputRef,
}) implements Command {
  @override
  List<String> get assemblyLines {
    return [
      '# load the int',
      'adrp x1, $dataRef@PAGE',
      'add x1, x1, $dataRef@PAGEOFF',
      'ldr x0, [x1]',
      '# premate output',
      'adrp x1, $outputRef@PAGE',
      'add x1, x1, $outputRef@PAGEOFF',
      '# convert and store',
      'bl int_to_str',
    ];
  }
}
