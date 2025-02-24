import 'package:flutter_test/flutter_test.dart';
import 'package:ft_base/ft_base.dart';
import 'package:ft_base/ft_base_platform_interface.dart';
import 'package:ft_base/ft_base_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFtBasePlatform
    with MockPlatformInterfaceMixin
    implements FtBasePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FtBasePlatform initialPlatform = FtBasePlatform.instance;

  test('$MethodChannelFtBase is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFtBase>());
  });

  test('getPlatformVersion', () async {
    FtBase ftBasePlugin = FtBase();
    MockFtBasePlatform fakePlatform = MockFtBasePlatform();
    FtBasePlatform.instance = fakePlatform;

    expect(await ftBasePlugin.getPlatformVersion(), '42');
  });
}
