import '../_domain.dart';

class StringDataParser implements Parser {
  @override
  ParsedSection parseSection(Section section) {
    final String str = section.current;
    if (!str.startsWith("'") || !str.endsWith("'")) {
      throw "StringData should start and end with `'`; got: ${str}";
    }

    final Data data = StringData(
      ref: Data.getNextRef(),
      data: str.substring(1, str.length - 1),
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
