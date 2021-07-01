import 'package:cmakenew/cmake_util.dart';
import 'package:test/test.dart';

void main() {
  test('check cmake installed check', () async {

    var cMakeUtil = CMakeUtil();
    expect(await cMakeUtil.cmakeInstalled(), true);    

  });
}
