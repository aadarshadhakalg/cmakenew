import 'dart:io';
import 'package:io/io.dart';
import 'package:mason/mason.dart';

class CMakeUtil {

  final _logger = Logger();

  bool cmakeInstalled()  {
    try{
    var result =  Process.runSync('cmake', ['--version']);

    if (result.exitCode == ExitCode.success.code) {
      return true;
    }
    }catch(e){
      return false;
    }
    return false;
  }

  Future<bool> cmakeGenerate(String path) async {
    
    try{
    var _result = await Process.run(
      'cmake',
      ['..'],
      workingDirectory: path,
    );

    if (_result.exitCode != ExitCode.success.code) {
      _logger.err(_result.stderr);
      return false;
    } else {
      _logger.info(_result.stdout);
      return true;
    }
    }catch(e){
      _logger.err(e.toString());
      return false;
    }
  }

  bool cmakeNewOnPath() {
    try{
    var result =  Process.runSync('cmakenew',[]);

    if (result.exitCode == ExitCode.success.code) {
      return true;
    }
    }catch(e){
      return false;
    }
    return false;
  }
}
