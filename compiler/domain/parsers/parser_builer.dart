import '../_domain.dart';
import 'string_data_parser.dart';

class ParserBuiler {
  const ParserBuiler._();

  static Parser forSection(Section section) {
    for (final supportedCommand in SupportedCommands.values) {
      if (section.current.startsWith(supportedCommand.string)) {
        return switch (supportedCommand) {
          SupportedCommands.print => PrintParser(),
          SupportedCommands.intToStr => IntToStrParser(),
        };
      }
    }

    if (section.current.startsWith("'")) {
      return StringDataParser();
    }
    if (int.tryParse(section.current) != null) {
      return IntDataParser();
    }

    throw 'Unrecognized section type';
  }
}
