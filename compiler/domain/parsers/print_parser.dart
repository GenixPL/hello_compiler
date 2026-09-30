import '../../utils/_utils.dart';
import '../_domain.dart';

class PrintParser implements Parser {
  const PrintParser();

  @override
  ParsedSection parseSection(String section) {
    final Data data = Data(
      ref: Data.getNextRef(),
      data: betweenBrackets(section),
    );

    final PrintCommand command = PrintCommand(
      dataRef: data.ref,
    );

    return ParsedSection(
      command: command,
      data: data,
    );
  }
}
