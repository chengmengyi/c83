import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ft_a_method_channel.dart';

abstract class Ft_aPlatform extends PlatformInterface {
  /// Constructs a Ft_aPlatform.
  Ft_aPlatform() : super(token: _token);

  static final Object _token = Object();

  static Ft_aPlatform _instance = MethodChannelFt_a();

  /// The default instance of [Ft_aPlatform] to use.
  ///
  /// Defaults to [MethodChannelFt_a].
  static Ft_aPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [Ft_aPlatform] when
  /// they register themselves.
  static set instance(Ft_aPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
