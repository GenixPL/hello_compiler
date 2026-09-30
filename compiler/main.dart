import 'dart:io';

import 'domain/parsers/_parsers.dart';
import 'utils/_utils.dart';

void main(List<String> args) {
  p("start");

  final AssemblyBuilder assemblyBuilder = AssemblyBuilder();
  final ParserBuiler parserBuiler = ParserBuiler();

  final List<String> sections = readSections(args[0]);
  for (final section in sections) {
    final Parser? parser = parserBuiler.forSection(section);
    if (parser == null) {
      p('UNRECOGNIZED SECTION');
      continue;
    }

    final ParsedSection parsedSection = parser.parseSection(section);
    assemblyBuilder.commands.add(parsedSection.command);
    assemblyBuilder.data.add(parsedSection.data);
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
