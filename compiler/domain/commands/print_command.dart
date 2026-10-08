
import '../_domain.dart';

class PrintCommand({
required final StringData stringData,
}) implements Command {
  @override
  List<String> get assemblyLines {
    return [
      'adrp x0, ${stringData.ref}@PAGE',
      'add x0, x0, ${stringData.ref}@PAGEOFF',
      'bl print',
    ];
  }
}
