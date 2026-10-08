import '../_domain.dart';

class IntToStrParser implements Parser {
  const IntToStrParser();

  @override
  ParsedSection parseSection(Section section) {
    if (section.children.length != 1) {
      throw 'Wrong number of arguments for `intToStr`; expected 1, got: ${section.children.length}';
    }

    final Section child = section.children.first;
    final Parser childParser = ParserBuiler.forSection(child);
    final ParsedSection childReturn = childParser.parseSection(child);
    final Data? childReturnData = childReturn.returnData;

    if (childReturnData is! IntData) {
      throw "Wrong argument passed to `intToStr`; expected IntData, got: ${childReturnData}";
    }

    final Data outputData = StringData(
      data: '',
      ref: Data.getNextRef(),
    );

    return ParsedSection(
      returnData: outputData,
      commands: [
        ...childReturn.commands,
        IntToStrCommand(
          dataRef: childReturnData.ref,
          outputRef: outputData.ref
        ),
      ],
      data: [
        ...childReturn.data,
        outputData,
      ],
    );
  }
}
