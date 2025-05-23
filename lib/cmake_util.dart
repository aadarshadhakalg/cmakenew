import 'dart:io';
import 'package:mason/mason.dart';

class CMakeUtil {

  final logger = Logger();

  bool cmakeInstalled()  {
    try{
    var result = Process.runSync('cmake', ['--version']) ;

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
    var result = await Process.run(
     Platform.isLinux ? 'cmake' : 'cmake -G "MinGW Makefiles"',
      ['..'],
      workingDirectory: path,
    );

    if (result.exitCode != ExitCode.success.code) {
      logger.err(result.stderr);
      return false;
    } else {
      logger.info(result.stdout);
      return true;
    }
    }catch(e){
      logger.err(e.toString());
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
