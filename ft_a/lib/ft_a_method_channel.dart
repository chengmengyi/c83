import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ft_a_platform_interface.dart';

/// An implementation of [Ft_aPlatform] that uses method channels.
class MethodChannelFt_a extends Ft_aPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ft_a');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
