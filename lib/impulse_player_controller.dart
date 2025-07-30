import 'dart:ffi';

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

  Future<void> setCastEnabled(bool enabled) async {
    final id = await ImpulsePlayerFactory.getViewId(this);
    return ImpulsePlayerPluginPlatform.instance.setCastEnabled(id, enabled);
  }

  Future<void> load(
    String url, 
    {
      String? title,
      String? subtitle, 
      Map<String, String> headers = const {},
    }) async {
    final id = await ImpulsePlayerFactory.getViewId(this);
    return ImpulsePlayerPluginPlatform.instance.load(id, url, title, subtitle, headers);
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

  /// Manually keeps the underlying native player alive beyond the lifetime of its associated view.
  ///
  /// **⚠️ Use with caution.**
  ///
  /// This method should **only** be used when you need the player instance to persist
  /// beyond the lifecycle of the view — for example, in advanced cases where you're
  /// managing player state manually across multiple views or routes.
  ///
  /// In most typical scenarios, the `ImpulsePlayer` handles cleanup automatically
  /// when the view is disposed. Using this method bypasses that behavior and may lead
  /// to memory leaks or unintended playback behavior if not managed correctly.
  ///
  /// > Note: This API is likely to be **removed in a future version**, once full
  /// media control lifecycle management is implemented in the plugin.
  Future<void> keepAlive() async {
    final id = await ImpulsePlayerFactory.getViewId(this);
    return ImpulsePlayerPluginPlatform.instance.keepAlive(id);
  }

  /// Manually disposes of a previously retained native player instance.
  ///
  /// **⚠️ Use with caution.**
  ///
  /// This should be used in conjunction with [keepAlive] when you've explicitly
  /// retained a player beyond the view's lifetime. It ensures the native resources
  /// are released when no longer needed.
  ///
  /// If you haven't used [keepAlive], you typically do **not** need to call this method,
  /// as `ImpulsePlayer` automatically disposes of resources during normal lifecycle cleanup.
  ///
  /// > Note: This API is likely to be **removed in a future version**, once full
  /// media control lifecycle management is implemented in the plugin.
  Future<void> dispose() async {
    final id = await ImpulsePlayerFactory.getViewId(this);
    return ImpulsePlayerPluginPlatform.instance.dispose(id);
  }
}
