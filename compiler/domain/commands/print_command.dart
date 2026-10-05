
import '../_domain.dart';

class PrintCommand({
  required final String dataRef,
  final String register = 'x0',
}) implements Command {
  @override
  List<String> get assemblyLines {
    return [
      'adrp $register, $dataRef@PAGE',
      'add $register, $register, $dataRef@PAGEOFF',
      'bl print',
    ];
  }
}
