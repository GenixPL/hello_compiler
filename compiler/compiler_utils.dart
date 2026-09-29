import 'dart:io';

import 'main.dart';

void p(String msg) {
  print('DUPA $msg');
}

List<String> readSections(
  String filePath, {
  String separator = ';',
}) {
  final File file = File(filePath);
  final fileString = file.readAsStringSync();
  // This splits by the separtor, and already removes the separators.
  List<String> sections = fileString.split(separator);
  // Gets rid of white spaces between commands.
  sections = sections.map((s) => s.trim()).toList();
  // Removes empty sections, always one due to split, but also `;;`.
  sections.removeWhere((s) => s.isEmpty);
  return sections;
}

String betweenBrackets(String string) {
  final int start = string.indexOf('(');
  final int end = string.lastIndexOf(')');
  return string.substring(
    // + (
    // '
    start + 2,
    // - '
    end - 1,
  );
}

({PrintCommand command, Data data}) parsePrint({
  required String section,
}) {
  final Data data = Data(
    ref: Data.getNextRef(),
    data: betweenBrackets(section),
  );

  return (
    command: PrintCommand(
      dataRef: data.ref,
    ),
    data: data,
  );
}
