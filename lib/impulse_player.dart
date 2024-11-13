import 'package:flutter/material.dart';
import 'package:impulse_player_flutter/plugin/plugin_platform.dart';

abstract class ImpulsePlayer {
  static void setAppearance(
    TextStyle h3,
    TextStyle h4,
    TextStyle s1,
    TextStyle l4,
    TextStyle l7,
    TextStyle p1,
    TextStyle p2,
    Color accentColor,
  ) async {
    ImpulsePlayerPluginPlatform.instance.setAppearance(
      h3, h4, s1, l4, l7, p1, p2, accentColor,
    );
  }
}
