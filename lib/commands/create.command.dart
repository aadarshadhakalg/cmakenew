import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:cmakenew/cmakenew.dart';
import 'package:cmakenew/templates/cmakeproject_bundle.dart';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;

class CreateCommand extends Command {
  final _logger = Logger();

  @override
  CommandRunner? get runner => CMakeNewCommandRunner(name,description);

  @override
  String get description => 'Creates new cmake project';

  @override
  String get name => 'create';

  CreateCommand() {
    argParser.addOption('project-name',
        help: 'Name of the project', mandatory: true);
    argParser.addOption('cmake-version',help: 'Cmake version to use in the project');
    argParser.addOption(
      'device',
      abbr: 'd',
      help: 'Select device',
      defaultsTo: 'linux',
      allowed: ['windows', 'linux'],
    );
  }

  @override
  Future<void> run() async {
    var logBootstrap = _logger.progress('Bootstrapping...');

    var generator = await MasonGenerator.fromBundle(cmakeprojectBundle);
    var _generatorTarget =
        DirectoryGeneratorTarget(Directory('${path.current}'), _logger);
    await generator.generate(
      _generatorTarget,
      vars: {
        'version': argResults?['cmake-version'] ?? '3.10',
        'projectname': argResults?['project-name'],
      },
    );

    logBootstrap();
    _logger.success('Project Generated Syccessfully');
  }
}
