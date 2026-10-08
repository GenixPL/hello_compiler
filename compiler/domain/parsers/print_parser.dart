import '../_domain.dart';

class PrintParser implements Parser {
  const PrintParser();

  @override
  ParsedSection parseSection(Section section) {
    if (section.children.length != 1) {
      throw 'Wrong number of arguments for `print`; expected 1, got: ${section.children.length}';
    }

    final Section child = section.children.first;
    final Parser childParser = ParserBuiler.forSection(child);
    final ParsedSection childReturn = childParser.parseSection(child);
    final Data? childReturnData = childReturn.returnData;

    if (childReturnData is! StringData) {
      throw "Wrong argument passed to `print`; expected StringData, got: ${childReturnData}";
    }

    return ParsedSection(
      returnData: null,
      commands: [
        ...childReturn.commands,
        PrintCommand(
          stringData: childReturnData,
        ),
      ],
      data: [
        ...childReturn.data,
      ],
    );
  }
}
