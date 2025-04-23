import 'package:flutter/material.dart';
import 'package:impulse_player_flutter/plugin/plugin_platform.dart';

abstract class ImpulsePlayer {
  static void setAppearance({
    required TextStyle h3,
    required TextStyle h4,
    required TextStyle s1,
    required TextStyle l4,
    required TextStyle l7,
    required TextStyle p1,
    required TextStyle p2,
    required Color accentColor,
  }) async {
    ImpulsePlayerPluginPlatform.instance.setAppearance(
      h3, h4, s1, l4, l7, p1, p2, accentColor,
    );
  }

  static void setSettings({
    required bool pictureInPictureEnabled,
    required String? castReceiverApplicationId,
  }) async {
    ImpulsePlayerPluginPlatform.instance.setSettings(
      pictureInPictureEnabled,
      castReceiverApplicationId,
    );
  }
}
