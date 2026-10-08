enum SupportedCommands {
  print('print'),
  intToStr('intToStr'),
  intAdd('intAdd'),
  ;

  const SupportedCommands(this.string);

  final String string;
}
