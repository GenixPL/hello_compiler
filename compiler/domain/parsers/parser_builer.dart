import '../_domain.dart';

class ParserBuiler {
  const ParserBuiler();

  Parser? forSection(String section) {
    for (final supportedCommand in SupportedCommands.values) {
      if (section.startsWith(supportedCommand.string)) {
        return switch (supportedCommand) {
          SupportedCommands.print => PrintParser(),
          SupportedCommands.str => StrParser(),
        };
      }
    }

    return null;
  }
}
