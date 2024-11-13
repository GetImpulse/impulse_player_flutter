import Flutter
import UIKit
import ImpulsePlayer

public class ImpulsePlayerPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: PluginConstants.pluginTag, binaryMessenger: registrar.messenger())
        let instance = ImpulsePlayerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        registrar.register(
            PluginNativeViewFactory(channel: channel),
            withId: PluginConstants.viewTag
        )
        
        Task { @MainActor in
            ImpulsePlayer.setSettings(settings: ImpulsePlayerSettings(
                pictureInPictureEnabled: false
            ))
        }
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let method = PluginMethod.from(call: call) else {
            
            switch call.method {
            case "getPlatformVersion":
                result("iOS " + UIDevice.current.systemVersion)
            default:
                result(FlutterMethodNotImplemented)
            }
            
            return
        }
        
        Task { @MainActor in
            result(method.execute())
        }
    }
}
