import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:impulse_player_flutter/model/impulse_player_state.dart';
import 'package:impulse_player_flutter/plugin/impulse_player_factory.dart';
import 'package:impulse_player_flutter/plugin/impulse_player_plugin_constants.dart';

import 'plugin_platform.dart';

/// An implementation of [ImpulsePlayerPluginPlatform] that uses method channels.
class MethodChannelPlugin implements ImpulsePlayerPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel(ImpulsePlayerPluginConstants.PluginTag);
  
  MethodChannelPlugin() {
    methodChannel.setMethodCallHandler(_handleMethod);
  }

  Future<void> _handleMethod(MethodCall call) async {
    int id = call.arguments[ImpulsePlayerPluginConstants.ParameterId];
    switch (call.method) {
      case 'onStateChanged':
        // final state = call.arguments;
        // Handle the updated state from StateFlow here
        // print("State changed: $state");
        break;
      case ImpulsePlayerPluginConstants.CallbackOnReady:
        ImpulsePlayerFactory.getController(id)?.onReady?.call();
        break;
      case ImpulsePlayerPluginConstants.CallbackOnPlay:
        ImpulsePlayerFactory.getController(id)?.onPlay?.call();
        break;
      case ImpulsePlayerPluginConstants.CallbackOnPause:
        ImpulsePlayerFactory.getController(id)?.onPause?.call();
        break;
      case ImpulsePlayerPluginConstants.CallbackOnFinish:
        ImpulsePlayerFactory.getController(id)?.onFinish?.call();
        break;
      case ImpulsePlayerPluginConstants.CallbackOnError:
        String message = call.arguments[ImpulsePlayerPluginConstants.ParameterMessage];
        ImpulsePlayerFactory.getController(id)?.onError?.call(message);
        break;
      default:
        throw MissingPluginException("Unhandled method: ${call.method}");
    }
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> setCastEnabled(int id, bool enabled) async {
     await methodChannel.invokeMethod<void>(ImpulsePlayerPluginConstants.MethodSetCastEnabled, { 
      ImpulsePlayerPluginConstants.ParameterId: id, 
      ImpulsePlayerPluginConstants.ParameterEnabled: enabled, 
    });
  }
  
  @override
  Future<void> load(int id, String url, String? title, String? subtitle, Map<String, String> headers) async {
     await methodChannel.invokeMethod<void>(ImpulsePlayerPluginConstants.MethodLoad, { 
      ImpulsePlayerPluginConstants.ParameterId: id, 
      ImpulsePlayerPluginConstants.ParameterUrl: url,
      ImpulsePlayerPluginConstants.ParameterTitle: title,
      ImpulsePlayerPluginConstants.ParameterSubtitle: subtitle,
      ImpulsePlayerPluginConstants.ParameterHeaders: headers,
    });
  }

  @override
  Future<void> play(int id) async {
     await methodChannel.invokeMethod<void>(ImpulsePlayerPluginConstants.MethodPlay, { 
      ImpulsePlayerPluginConstants.ParameterId: id, 
    });
  }

  @override
  Future<void> pause(int id) async {
     await methodChannel.invokeMethod<void>(ImpulsePlayerPluginConstants.MethodPause, { 
      ImpulsePlayerPluginConstants.ParameterId: id, 
    });
  }

  @override
  Future<void> seek(int id, Long time) async {
     await methodChannel.invokeMethod<void>(ImpulsePlayerPluginConstants.MethodSeek, { 
      ImpulsePlayerPluginConstants.ParameterId: id,
      ImpulsePlayerPluginConstants.ParameterTime: time,
    });
  }

  @override
  Future<bool> isPlaying(int id) async {
    return await methodChannel.invokeMethod<bool>(ImpulsePlayerPluginConstants.MethodIsPlaying, { 
      ImpulsePlayerPluginConstants.ParameterId: id,
    }) ?? false;
  }

  @override
  Future<ImpulsePlayerState> getState(int id) async {
    var raw = await methodChannel.invokeMethod<String>(ImpulsePlayerPluginConstants.MethodGetState, { 
      ImpulsePlayerPluginConstants.ParameterId: id,
    }) ?? "";
    return ImpulsePlayerState.fromValue(raw);
  }

  @override
  Future<int> getProgress(int id) async {
    return await methodChannel.invokeMethod<int>(ImpulsePlayerPluginConstants.MethodGetProgress, { 
      ImpulsePlayerPluginConstants.ParameterId: id,
    }) ?? 0;
  }

  @override
  Future<int> getDuration(int id) async {
    return await methodChannel.invokeMethod<int>(ImpulsePlayerPluginConstants.MethodGetDuration, { 
      ImpulsePlayerPluginConstants.ParameterId: id,
    }) ?? 0;
  }

  @override
  Future<String?> getError(int id) async {
    return await methodChannel.invokeMethod<String?>(ImpulsePlayerPluginConstants.MethodGetError, { 
      ImpulsePlayerPluginConstants.ParameterId: id,
    });
  }

  @override
  Future<void> keepAlive(int id) async {
    return await methodChannel.invokeMethod<void>(ImpulsePlayerPluginConstants.MethodKeepAlive, { 
      ImpulsePlayerPluginConstants.ParameterId: id,
    });
  }

  @override
  Future<void> dispose(int id) async {
    return await methodChannel.invokeMethod<void>(ImpulsePlayerPluginConstants.MethodDispose, { 
      ImpulsePlayerPluginConstants.ParameterId: id,
    });
  }
  
  @override
  Future<void> setAppearance(TextStyle h3, TextStyle h4, TextStyle s1, TextStyle l4, TextStyle l7, TextStyle p1, TextStyle p2, Color accentColor) async {
    await methodChannel.invokeMethod<void>(ImpulsePlayerPluginConstants.MethodSetAppearance, { 
      'h3': fontParams(h3),
      'h4': fontParams(h4),
      's1': fontParams(s1),
      'l4': fontParams(l4),
      'l7': fontParams(l7),
      'p1': fontParams(p1),
      'p2': fontParams(p2),
      'accent_color': accentColor.value,
    });
  }

  @override
  Future<void> setSettings(bool pictureInPictureEnabled, String? castReceiverApplicationId) async {
    await methodChannel.invokeMethod<void>(ImpulsePlayerPluginConstants.MethodSetSettings, {
      ImpulsePlayerPluginConstants.ParameterPictureInPictureEnabled: pictureInPictureEnabled,
      ImpulsePlayerPluginConstants.ParameterCastReceiverApplicationId: castReceiverApplicationId,
    });
  }

  Map<String, Object?> fontParams(TextStyle h3) {
    return {
      'size': h3.fontSize,
      'family': h3.fontFamily,
      'weight': h3.fontWeight?.value,
      'style': h3.fontStyle == FontStyle.italic ? ImpulsePlayerPluginConstants.ValueItalic : ImpulsePlayerPluginConstants.ValueNormal,
    };
  }
}
