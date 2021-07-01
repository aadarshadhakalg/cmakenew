import 'dart:io' as io;
import 'package:cmakenew/cmake_util.dart';
import 'package:cmakenew/cmakenew.dart';
import 'package:cmakenew/commands/create.command.dart';
import 'package:io/ansi.dart';
import 'package:io/io.dart';
import 'package:mason/mason.dart';

void main(List<String> arguments) async {
  final _logger = Logger();

  var runner = CMakeNewCommandRunner('cmakenew', 'Create a new project')
    ..addCommand(CreateCommand());

  runner.argParser.addFlag('info',
      abbr: 'i',
      help: 'Shows Developer Info',
      negatable: false, callback: (val) {
    if (val) {
      _logger.info(
        green.wrap('''
+-----------------------------------------------------------+
|               Welcome to the Cmake New CLI!               |
+-----------------------------------------------------------+
| Author: Aadarsha Dhakal                                   |
| Author's Profile: https://github.com/aadarshadhakalg      |
| Project Link: https://github.com/aadarshadhakalg/cmakenew |
+-----------------------------------------------------------+\n'''),
      );
      io.exit(ExitCode.usage.code);
    }
  });

  runner.argParser.addFlag('doctor',
      abbr: 'd',
      help: 'Environment Checkup',
      negatable: false, callback: (val) async {
    if (val) {
      var cmakeCheck =
          _logger.progress(yellow.wrap('Checking CMAKE in the system')!);
      if ( CMakeUtil().cmakeInstalled()) {
        cmakeCheck(green.wrap('Found CMAKE'));
      } else {
        cmakeCheck();
        _logger.err('CMAKE NOT FOUND');
      }

      var cmakeNewCheck =
          _logger.progress(yellow.wrap('Looking for CMAKENEW')!);
      if ( CMakeUtil().cmakeNewOnPath()) {
        cmakeNewCheck(green.wrap('CMAKENEW is on path'));
      } else {
        cmakeNewCheck();
        _logger.err('CMAKENEW is not on the path.');
      }
      io.exit(ExitCode.usage.code);
    }
  });

  await runner.run(arguments);
}
