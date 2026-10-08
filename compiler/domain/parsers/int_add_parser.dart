import '../_domain.dart';
import '../commands/int_add_command.dart';
import '../data.dart';
import 'parser.dart';
import 'section_parser.dart';

class IntAddParser implements Parser {
  @override
  ParsedSection parseSection(Section section) {
    if (section.children.length != 2) {
      throw 'Wrong number of arguments for `intAdd`; expected 2, got: ${section.children.length}';
    }

    final Section firstChild = section.children[0];
    final Parser firstChildParser = ParserBuiler.forSection(firstChild);
    final ParsedSection firstChildReturn = firstChildParser.parseSection(firstChild);
    final Data? firstChildReturnData = firstChildReturn.returnData;
    if (firstChildReturnData is! IntData) {
      throw "Wrong argument passed to `intAdd`; expected IntData, got: ${firstChildReturnData}";
    }

    final Section secondChild = section.children[1];
    final Parser secondChildParser = ParserBuiler.forSection(secondChild);
    final ParsedSection secondChildReturn = secondChildParser.parseSection(secondChild);
    final Data? secondChildReturnData = secondChildReturn.returnData;
    if (secondChildReturnData is! IntData) {
      throw "Wrong argument passed to `intAdd`; expected IntData, got: ${secondChildReturnData}";
    }

    final IntData outputData = IntData(
      data: 0,
      ref: Data.getNextRef(),
    );

    return ParsedSection(
      commands: [
        ...firstChildReturn.commands,
        ...secondChildReturn.commands,
        IntAddCommand(
          left: firstChildReturnData,
          right: secondChildReturnData,
          outputRef: outputData.ref,
        ),
      ],
      returnData: outputData,
      data: [
        ...firstChildReturn.data,
        ...secondChildReturn.data,
        outputData,
      ],
    );
  }
}
