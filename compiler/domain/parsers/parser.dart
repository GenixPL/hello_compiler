import '../_domain.dart';

abstract interface class Parser {
  ParsedSection parseSection(String section);
}

class const ParsedSection({
  required List<Command> command,
  required List<Data> data,
});
