import Flutter
import ImpulsePlayer

class PluginNativeViewFactory: NSObject {
    
    private let channel: FlutterMethodChannel
    
    init(channel: FlutterMethodChannel) {
        self.channel = channel
    }
    
    private static var instances = [Int64: ImpulsePlayerViewContainer]()
    
    static func get(_ id: Int64) -> ImpulsePlayerViewContainer? {
        return instances[id]
    }
    
    static func dispose(_ instance: ImpulsePlayerViewContainer) {
        instances.removeValue(forKey: instance.id)
    }
}

extension PluginNativeViewFactory: FlutterPlatformViewFactory {
    
    func create(
         withFrame frame: CGRect,
         viewIdentifier viewId: Int64,
         arguments args: Any?
     ) -> FlutterPlatformView {
         print("factory create \(viewId)")
         let instance = ImpulsePlayerViewContainer(id: viewId, delegate: PluginPlayerDelegate(channel, viewId))
         Self.instances[viewId] = instance
         return instance
     }
}

class PluginPlayerDelegate {
    let channel: FlutterMethodChannel
    let id: Int64
    
    init(_ channel: FlutterMethodChannel, _ id: Int64) {
        self.channel = channel
        self.id = id
    }
}

extension PluginPlayerDelegate: PlayerDelegate {
    
    func onReady(_ impulsePlayerView: ImpulsePlayerView) {
        print("factory onReady")
        PluginCallback.OnReady().execute(channel, id)
    }
    
    func onPlay(_ impulsePlayerView: ImpulsePlayerView) {
        print("factory onPlay")
        PluginCallback.OnPlay().execute(channel, id)
    }
    
    func onPause(_ impulsePlayerView: ImpulsePlayerView) {
        print("factory onPause")
        PluginCallback.OnPause().execute(channel, id)
    }
    
    func onFinish(_ impulsePlayerView: ImpulsePlayerView) {
        print("factory onFinish")
        PluginCallback.OnFinish().execute(channel, id)
    }
    
    func onError(_ impulsePlayerView: ImpulsePlayerView, message: String) {
        print("factory onError")
        PluginCallback.OnError(message: message).execute(channel, id)
    }
}
