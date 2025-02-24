import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ft_base_method_channel.dart';

abstract class FtBasePlatform extends PlatformInterface {
  /// Constructs a FtBasePlatform.
  FtBasePlatform() : super(token: _token);

  static final Object _token = Object();

  static FtBasePlatform _instance = MethodChannelFtBase();

  /// The default instance of [FtBasePlatform] to use.
  ///
  /// Defaults to [MethodChannelFtBase].
  static FtBasePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FtBasePlatform] when
  /// they register themselves.
  static set instance(FtBasePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
