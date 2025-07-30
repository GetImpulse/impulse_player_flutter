import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:impulse_player_flutter/model/impulse_player_state.dart';
import 'package:impulse_player_flutter/plugin/plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class ImpulsePlayerPluginPlatform extends PlatformInterface {
  /// Constructs a PluginPlatform.
  ImpulsePlayerPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  // static ImpulsePlayerPluginPlatform _instance = MethodChannelPlugin();
  static ImpulsePlayerPluginPlatform _instance = MethodChannelPlugin();

  /// The default instance of [ImpulsePlayerPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelPlugin].
  static ImpulsePlayerPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ImpulsePlayerPluginPlatform] when
  /// they register themselves.
  static set instance(ImpulsePlayerPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }
  
  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> setCastEnabled(int id, bool enabled) {
    throw UnimplementedError('load() has not been implemented.');
  }

  Future<void> load(int id, String url, String? title, String? subtitle, Map<String, String> headers) {
    throw UnimplementedError('load() has not been implemented.');
  }

  Future<void> play(int id) {
    throw UnimplementedError('play() has not been implemented.');
  }

  Future<void> pause(int id) {
    throw UnimplementedError('play() has not been implemented.');
  }

  Future<void> seek(int id, Long time) {
    throw UnimplementedError('seek(time) has not been implemented.');
  }

  Future<bool> isPlaying(int id) {
    throw UnimplementedError('isPlaying() has not been implemented.');
  }

  Future<ImpulsePlayerState> getState(int id) {
    throw UnimplementedError('getState() has not been implemented.');
  }

  Future<int> getProgress(int id) {
    throw UnimplementedError('getProgress() has not been implemented.');
  }

  Future<int> getDuration(int id) {
    throw UnimplementedError('getDuration() has not been implemented.');
  }

  Future<String?> getError(int id) {
    throw UnimplementedError('getError() has not been implemented.');
  }

  Future<void> keepAlive(int id) {
    throw UnimplementedError('keepAlive() has not been implemented.');
  }

  Future<void> dispose(int id) {
    throw UnimplementedError('dispose() has not been implemented.');
  }

  Future<void> setAppearance(
    TextStyle h3,
    TextStyle h4,
    TextStyle s1,
    TextStyle l4,
    TextStyle l7,
    TextStyle p1,
    TextStyle p2,
    Color accentColor,
  ) {
    throw UnimplementedError('setAppearance() has not been implemented.');
  }

  Future<void> setSettings(
    bool pictureInPictureEnabled,
    String? castReceiverApplicationId,
  ) {
    throw UnimplementedError('setAppearance() has not been implemented.');
  }
}
