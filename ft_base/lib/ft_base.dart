
import 'ft_base_platform_interface.dart';

class FtBase {
  Future<String?> getPlatformVersion() {
    return FtBasePlatform.instance.getPlatformVersion();
  }
}
