
import 'package:impulse_player_flutter/plugin/plugin_platform.dart';

class ImpulsePlayerPlugin {

  Future<String?> getPlatformVersion() {
    return ImpulsePlayerPluginPlatform.instance.getPlatformVersion();
  }
}
