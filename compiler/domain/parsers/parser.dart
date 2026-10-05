import '../_domain.dart';

abstract interface class Parser {
  ParsedSection parseSection(Section section);
}

class ParsedSection({
  required final List<Command> commands,
  required final Data? returnData,
  required final List<Data> data,
});
