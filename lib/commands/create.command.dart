import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:cmakenew/cmake_util.dart';
import 'package:cmakenew/templates/cmakeproject_bundle.dart';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;

class CreateCommand extends Command {
  final _logger = Logger();
  final _cmakeUtil = CMakeUtil();

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
    var logBootstrap = _logger.progress('Bootstrapping...');

    var generator = await MasonGenerator.fromBundle(cmakeprojectBundle);
    var _generatorTarget =
        DirectoryGeneratorTarget(Directory('${path.current}'), _logger);
    await generator.generate(
      _generatorTarget,
      vars: {
        'version': argResults?['cmake-version'] ?? '3.10',
        'projectname': argResults?['project-name'] ?? argResults?.arguments[0],
      },
    );

    logBootstrap('Project Files Generated');
    var _cmakeRun =
        _logger.progress('Runing cmake on ${_generatorTarget.dir}/build/');

    if ( _cmakeUtil.cmakeInstalled()) {
      if (await _cmakeUtil.cmakeGenerate(
        path.join(path.current, '${argResults?['project-name'] ?? argResults?.arguments[0]}', 'build'),
      )) {
        _cmakeRun('Project Created Successfully!');
      } else {
        _cmakeRun.call();
        _logger.err(
            'Cmake Error! Please make sure cmake version ${argResults?['cmake-version'] ?? "3.10"} is installed and is on system path!');
      }
    } else {
      _logger.err(
          'Cmake Error! Please make sure cmake is installed and is on system path!');
    }
  }
}
