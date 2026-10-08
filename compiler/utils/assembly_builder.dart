import '../domain/_domain.dart';

class AssemblyBuilder {
  final List<String> imports = [
    'exit',
    'print',
    'strlen',
    'int_add',
    'int_to_str',
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
      '.data',
      ...data.expand((data) {
        return [
          '${data.ref}:',
          for (final line in data.assembly) '  $line',
        ];
      }),
      '',
    ].join('\n');
  }
}
