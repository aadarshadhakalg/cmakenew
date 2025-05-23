import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:cmakenew/cmake_util.dart';
import 'package:cmakenew/templates/cmakeproject_bundle.dart';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;

class CreateCommand extends Command {
  final logger = Logger();
  final cmakeUtil = CMakeUtil();

  @override
  String get description => 'Creates new cmake project';

  @override
  String get name => 'create';

  CreateCommand() {
    argParser.addOption('project-name',
        help: 'Name of the project', mandatory: false);
    argParser.addOption('cmake-version',
        help: 'Cmake version to use in the project');
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
    final logBootstrap = logger.progress('Bootstrapping...');

    var generator = await MasonGenerator.fromBundle(cmakeprojectBundle);
    var generatorTarget =
        DirectoryGeneratorTarget(Directory(path.current), logger: logger);
    await generator.generate(
      generatorTarget,
      vars: {
        'version': argResults?['cmake-version'] ?? '3.10',
        'projectname': argResults?['project-name'] ?? argResults?.arguments[0],
      },
    );

    logBootstrap.complete('Project Files Generated');
    final cmakeRun =
        logger.progress('Running cmake on ${generatorTarget.dir.path}');

    if ( cmakeUtil.cmakeInstalled()) {
      if (await cmakeUtil.cmakeGenerate(
        path.join(path.current, '${argResults?['project-name'] ?? argResults?.arguments[0]}', 'build'),
      )) {
        cmakeRun.complete('Project Created Successfully!');
      } else {
        cmakeRun.fail();
        logger.err(
            'Cmake Error! Please make sure cmake version ${argResults?['cmake-version'] ?? "3.10"} is installed and is on system path!');
      }
    } else {
      logger.err(
          'Cmake Error! Please make sure cmake is installed and is on system path!');
    }
  }
}
