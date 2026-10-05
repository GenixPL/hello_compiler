import 'dart:io';

import 'domain/parsers/_parsers.dart';
import 'utils/_utils.dart';

void main(List<String> args) {
  p("start");

  final AssemblyBuilder assemblyBuilder = AssemblyBuilder();
  final SectionParser sectionParser = SectionParser();

  final File inputFile = File(args[0]);
  final Section mainSection = sectionParser.main(inputFile.readAsStringSync());

  p(mainSection.toString());

  for (final section in mainSection.children) {
    _mapSection(
      section: section,
      builder: assemblyBuilder,
    );
  }

  final String build = assemblyBuilder.build();

  final File outputFile = File('${args[1]}main.s');
  outputFile.createSync(
    recursive: true,
  );
  outputFile.writeAsString(build);

  p('\n$build\n');

  p("end");
}

void _mapSection({
  required Section section,
  required AssemblyBuilder builder,
}) {
  final Parser parser = ParserBuiler.forSection(section);
  final ParsedSection parsedSection = parser.parseSection(section);
  builder.commands.addAll(parsedSection.commands);
  builder.data.addAll(parsedSection.data);
}
