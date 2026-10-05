import '../_domain.dart';

class IntToStrParser implements Parser {
  const IntToStrParser();

  @override
  ParsedSection parseSection(Section section) {
    if (section.children.length != 1) {
      throw 'Wrong number of arguments for `print`; expected 1, got: ${section.children.length}';
    }

    final Section child = section.children.first;
    final Parser childParser = ParserBuiler.forSection(child);
    final ParsedSection childReturn = childParser.parseSection(child);
    final Data? childReturnData = childReturn.returnData;

    if (childReturnData is! IntData) {
      throw "Wrong argument passed to `str`; expected IntData, got: ${childReturnData}";
    }

    final Data data = StringData(
      data: childReturnData.data.toString(),
      ref: Data.getNextRef(),
    );

    return ParsedSection(
      returnData: data,
      commands: [
        ...childReturn.commands,
        IntToStrCommand(
          dataRef: childReturnData.ref,
        ),
      ],
      data: [
        ...childReturn.data,
        data,
      ],
    );
  }
}
