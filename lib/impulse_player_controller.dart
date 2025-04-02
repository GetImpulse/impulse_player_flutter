import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:impulse_player_flutter/model/impulse_player_state.dart';
import 'package:impulse_player_flutter/plugin/impulse_player_factory.dart';
import 'package:impulse_player_flutter/plugin/plugin_platform.dart';

class ImpulsePlayerController {

  String id = DateTime.now().microsecondsSinceEpoch.toString();
  
  void Function()? onReady;
  void Function()? onPlay;
  void Function()? onPause;
  void Function()? onFinish;
  void Function(String message)? onError;

  ImpulsePlayerController({
    this.onReady,
    this.onPlay,
    this.onPause,
    this.onFinish,
    this.onError,
  });

  Future<void> load(String? title, String? subtitle, String url) async {
    final id = await ImpulsePlayerFactory.getViewId(this);
    return ImpulsePlayerPluginPlatform.instance.load(id, title, subtitle, url);
  }

  Future<void> play() async {
    final id = await ImpulsePlayerFactory.getViewId(this);
    return ImpulsePlayerPluginPlatform.instance.play(id);
  }

  Future<void> pause() async {
    final id = await ImpulsePlayerFactory.getViewId(this);
    return ImpulsePlayerPluginPlatform.instance.pause(id);
  }

  Future<void> seek(Long time) async {
    final id = await ImpulsePlayerFactory.getViewId(this);
    return ImpulsePlayerPluginPlatform.instance.seek(id, time);
  }

  Future<bool> isPlaying() async {
    final id = await ImpulsePlayerFactory.getViewId(this);
    return ImpulsePlayerPluginPlatform.instance.isPlaying(id);
  }

  Future<ImpulsePlayerState> getState() async {
    final id = await ImpulsePlayerFactory.getViewId(this);
    return ImpulsePlayerPluginPlatform.instance.getState(id);
  }

  Future<int> getProgress() async {
    final id = await ImpulsePlayerFactory.getViewId(this);
    return ImpulsePlayerPluginPlatform.instance.getProgress(id);
  }

  Future<int> getDuration() async {
    final id = await ImpulsePlayerFactory.getViewId(this);
    return ImpulsePlayerPluginPlatform.instance.getDuration(id);
  }

  Future<String?> getError() async {
    final id = await ImpulsePlayerFactory.getViewId(this);
    return ImpulsePlayerPluginPlatform.instance.getError(id);
  }
}