import '../_domain.dart';

abstract interface class Parser {
  ParsedSection parseSection(String section);
}

class ParsedSection({
  required final Command command,
  required final Data data,
});
