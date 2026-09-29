import 'dart:io';

import 'compiler_utils.dart';

void main(List<String> args) {
  p("start");

  final Builder builder = Builder();

  final List<String> sections = readSections(args[0]);
  for (final section in sections) {
    if (section.startsWith('print')) {
      final parsed = parsePrint(
        section: section,
      );
      builder.commands.add(parsed.command);
      builder.data.add(parsed.data);
    }
  }

  final String build = builder.build();

  final File outputFile = File('${args[1]}main.s');
  outputFile.createSync(
    recursive: true,
  );
  outputFile.writeAsString(build);

  p('\n$build\n');

  p("end");
}

class Builder {
  final List<String> imports = [
    'exit',
    'print',
    'strlen',
  ];

  final List<Data> data = [];

  final List<Command> commands = [];

  String build() {
    return [
      //
      '.global _main',
      '.align 4',
      '',

      //
      for (final import in imports) '.extern $import',
      '',

      //
      '_main:',

      //
      ...commands.expand((command) {
        return [
          for (final line in command.assemblyLines) '  $line',
          '  ',
        ];
      }),

      //
      '  b exit',
      '',

      //
      '.data:',
      ...data.expand((data) {
        return [
          '${data.ref}:',
          '  .asciz "${data.data}"',
        ];
      }),
      '',
    ].join('\n');
  }
}

class const Data({
  required final String ref,
  required final String data,
}) {
  static int _counter = 0;

  static String getNextRef() {
    return 'd_${_counter++}';
  }
}

abstract interface class Command {
  List<String> get assemblyLines;
}

class PrintCommand({
  required final String dataRef,
  final String register = 'x0',
}) implements Command {
  @override
  List<String> get assemblyLines {
    return [
      'adrp $register, $dataRef@PAGE',
      'add  $register, $register, $dataRef@PAGEOFF',
      'bl print',
    ];
  }
}
