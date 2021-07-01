import 'package:cmakenew/cmake_util.dart';
import 'package:test/test.dart';

void main() {
  test('check cmake installed check', () {
    var cMakeUtil = CMakeUtil();
    expect(cMakeUtil.cmakeInstalled(), true);
  });
}
