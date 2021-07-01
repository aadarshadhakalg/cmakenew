import 'dart:io';
import 'package:cmakenew/cmakenew.dart';
import 'package:cmakenew/commands/create.command.dart';
import 'package:io/ansi.dart';
import 'package:io/io.dart';
import 'package:mason/mason.dart';

void main(List<String> arguments) async {
  var runner = CMakeNewCommandRunner('cmakenew', 'Create a new project')
    ..addCommand(CreateCommand());

  runner.argParser.addFlag('info',
      abbr: 'i',
      help: 'Shows Developer Info',
      negatable: false, callback: (fds) {
    Logger().info(
      green.wrap('''
+-----------------------------------------------------------+
|               Welcome to the Cmake New CLI!               |
+-----------------------------------------------------------+
| Author: Aadarsha Dhakal                                   |
| Author's Profile: https://github.com/aadarshadhakalg      |
| Project Link: https://github.com/aadarshadhakalg/cmakenew |
+-----------------------------------------------------------+\n'''),
    );
    if (fds) {
      exit(ExitCode.usage.code);
    }
  });

  await runner.run(arguments);
}
