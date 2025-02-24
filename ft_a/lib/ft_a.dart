
import 'ft_a_platform_interface.dart';

class Ft_a {
  Future<String?> getPlatformVersion() {
    return Ft_aPlatform.instance.getPlatformVersion();
  }
}
