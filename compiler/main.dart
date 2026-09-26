import 'compiler_utils.dart';

void main(List<String> args) {
  p("start");

  final List<String> sections = readSections(args[0]);
  for (final section in sections) {
    if (section.startsWith('print')) {
      
    }
  }

  p("end");
}
