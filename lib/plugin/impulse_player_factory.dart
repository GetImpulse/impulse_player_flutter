import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:impulse_player_flutter/impulse_player_controller.dart';
import 'package:impulse_player_flutter/plugin/impulse_player_plugin_constants.dart';

class ImpulsePlayerFactory {

  static final Map<String, ImpulsePlayerController> _controllers = {}; // controller id to controller
  static final Map<String, int> _attachs = {}; // controller id to view id

  static getViewId(ImpulsePlayerController controller) async {
    while (_attachs[controller.id] == null) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    return _attachs[controller.id];
  }

  static ImpulsePlayerController? getController(int viewId) {
    String controllerId = _attachs.entries
      .firstWhere(
        (entry) => entry.value == viewId,
      )
      .key;
      return _controllers[controllerId];
  }

  static Widget createView(BuildContext context, ImpulsePlayerController controller) {
    var platform = Theme.of(context).platform;
    switch (platform) {
      case TargetPlatform.android:
        const Map<String, dynamic> creationParams = <String, dynamic>{};

        return PlatformViewLink(
          viewType: ImpulsePlayerPluginConstants.ViewTag,
          surfaceFactory: (context, controller) {
            return AndroidViewSurface(
              controller: controller as AndroidViewController,
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<HorizontalDragGestureRecognizer>(() => HorizontalDragGestureRecognizer()),
              },
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
            );
          },
          onCreatePlatformView: (params) {
            return PlatformViewsService.initSurfaceAndroidView(
                id: params.id,
                viewType: ImpulsePlayerPluginConstants.ViewTag,
                layoutDirection: TextDirection.ltr,
                creationParams: creationParams,
                creationParamsCodec: const StandardMessageCodec(),
                onFocus: () {
                  params.onFocusChanged(true);
                },
              )
              ..addOnPlatformViewCreatedListener((id) {
                      _attachs[controller.id] = id;
                      _controllers[controller.id] = controller;
              })
              ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
              ..create();
          },
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: ImpulsePlayerPluginConstants.ViewTag,
          onPlatformViewCreated: (int id) {
            _attachs[controller.id] = id;
            _controllers[controller.id] = controller;
          },
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<HorizontalDragGestureRecognizer>(() => HorizontalDragGestureRecognizer()),
          },
        );
      default: 
        return const Center(child: Text("This platform is not supported."));
    }
  }

  static void dispose(ImpulsePlayerController controller) {
    _controllers.remove(controller.id);
    _attachs.remove(controller.id);
  }
}
