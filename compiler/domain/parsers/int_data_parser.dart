import '../_domain.dart';

class IntDataParser implements Parser {
  @override
  ParsedSection parseSection(Section section) {
    final int dataValue = int.parse(section.current);

    final IntData data = IntData(
      ref: Data.getNextRef(),
      data: dataValue,
    );

    return ParsedSection(
      commands: [],
      returnData: data,
      data: [
        data,
      ],
    );
  }
}
