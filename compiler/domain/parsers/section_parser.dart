import '../_domain.dart';

class Section({
  required final String current,

  // If there is `;` or `,`, it creates a child.
  required final List<Section> children,
});

class SectionParser {
  const SectionParser();

  Section main(String code) {
    return Section(
      current: 'main',
      children: parseChildren(code),
    );
  }

  List<Section> parseChildren(String section) {
    // Split children by `;`.
    final List<String> lines = section.split(';')
      ..removeWhere((line) => line.isEmpty);
    if (lines.isNotEmpty) {
      return [
        for (final line in lines) ...parseChildren(line),
      ];
    }

    // Split by commands
    for (final command in SupportedCommands.values) {
      if (section.startsWith(command.string)) {
        return [
          Section(
            current: command.string,
            children: parseChildren(section.replaceFirst(command.string, '')),
          ),
        ];
      }
    }

    // Split by `()`.
    if (section.startsWith('(') && section.endsWith(')')) {
      return parseChildren(section.substring(1, section.length - 1));
    }

    // At this point we should be dealing with leaf data nodes.

    // TODO(genix): split by `,` will come here

    if (section.startsWith("'") && section.endsWith("'")) {
      return [
        Section(
          current: section,
          children: [],
        ),
      ];
    }

    throw 'Unsupported section: ${section}';
  }
}
