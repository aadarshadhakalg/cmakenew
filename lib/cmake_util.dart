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
    String executable = 'cmake';
    List<String> arguments;

    if (Platform.isWindows) {
      arguments = ['-G', 'MinGW Makefiles', '..'];
    } else { // For Linux, macOS, and other platforms
      arguments = ['..'];
    }

    var result = await Process.run(
      executable,
      arguments,
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
