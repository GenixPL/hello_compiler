import '../_domain.dart';

class IntAddCommand({
  required final IntData left,
  required final IntData right,
  required final String outputRef,
}) implements Command {
  @override
  List<String> get assemblyLines {
    return [
      '# add',
      'mov x0, ${left.data}',
      'mov x1, ${right.data}',
      'bl int_add',

      '# store output',
      'adrp x1, $outputRef@PAGE',
      'add x1, x1, $outputRef@PAGEOFF',
      'str x0, [x1]',
    ];
  }
}
