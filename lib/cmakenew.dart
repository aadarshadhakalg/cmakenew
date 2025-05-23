import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';

class CMakeNewCommandRunner extends CommandRunner {
  CMakeNewCommandRunner(super.executableName, super.description) {
    logger = Logger();
  }

  late final Logger logger;

  @override
  Future<int> run(Iterable<String> args) async {
    try {
      final argResults = parse(args);
      return await runCommand(argResults) ?? ExitCode.success.code;
      
    } on FormatException catch (e, stackTrace) {
      logger
        ..err(e.message)
        ..err('$stackTrace')
        ..info('')
        ..info(usage);
      return ExitCode.usage.code;
    } on UsageException catch (e) {
      logger
        ..err(e.message)
        ..info('')
        ..info(usage);
      return ExitCode.usage.code;
    }
  }
}
