import 'dart:io';

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
