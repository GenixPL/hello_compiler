import '../_domain.dart';

class Section({
  required final String current,

  // If there is `;` or `,`, it creates a child.
  required final List<Section> children,
}) {
  String toString({
    int depth = 0,
  }) {
    return [
      '${"  " * depth} $current',
      for (final child in children)
        child.toString(
          depth: depth + 1,
        ),
    ].join('\n');
  }
}

class SectionParser {
  const SectionParser();

  Section main(String code) {
    return Section(
      current: 'main',
      children: parseChildren(code),
    );
  }

  List<Section> parseChildren(String section) {
    if (section.contains(';')) {
      // Split children by `;`.
      final List<String> lines = section
          .split(';')
          .map((l) => l.trim())
          .toList();
      lines.removeWhere((line) => line.isEmpty);
      if (lines.isNotEmpty) {
        return [
          for (final line in lines) ...parseChildren(line),
        ];
      }
    }

    // Split by commands
    for (final command in SupportedCommands.values) {
      // print(
      //   'D: command: $command section: $section startsWith: ${section.startsWith(command.string)}',
      // );
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

    if (section.contains(',')) {
      final List<String> parts = section
          .split(",")
          .map((l) => l.trim())
          .toList();
      parts.removeWhere((line) => line.isEmpty);
      return [
        for (final part in parts) ...parseChildren(part),
      ];
    }

    // ===
    // At this point we should be dealing with leaf data nodes.

    if (section.startsWith("'") && section.endsWith("'")) {
      return [
        Section(
          current: section,
          children: [],
        ),
      ];
    }
    if (int.tryParse(section) != null) {
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
