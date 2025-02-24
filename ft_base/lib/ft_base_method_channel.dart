import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ft_base_platform_interface.dart';

/// An implementation of [FtBasePlatform] that uses method channels.
class MethodChannelFtBase extends FtBasePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ft_base');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
