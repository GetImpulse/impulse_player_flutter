import Flutter
import Foundation

internal class PluginCallback {
    
    let name: String
    
    class OnReady: PluginCallback {
        init() {
            super.init(name: PluginConstants.Callback.onReady)
        }
    }
    
    class OnPlay: PluginCallback {
        init() {
            super.init(name: PluginConstants.Callback.onPlay)
        }
    }
    
    class OnPause: PluginCallback {
        init() {
            super.init(name: PluginConstants.Callback.onPause)
        }
    }
    
    class OnFinish: PluginCallback {
        init() {
            super.init(name: PluginConstants.Callback.onFinish)
        }
    }
    
    class OnError: PluginCallback {
        let message: String
        
        init(message: String) {
            self.message = message
            super.init(name: PluginConstants.Callback.onError)
        }
    }
    
    private init(name: String) {
        self.name = name
    }

    func execute(_ channel: FlutterMethodChannel, _ id: Int64) {
        var parameters: [String: Any] = [
            PluginConstants.Parameter.id: id
        ]
        
        switch self {
        case is OnError:
            if let errorCallback = self as? OnError {
                parameters[PluginConstants.Parameter.message] = errorCallback.message
            }
            
        case is OnReady,
            is OnPlay,
            is OnPause,
            is OnFinish:
            // Nothing additional
            break
        default:
            // Nothing additional
            break
        }
        
        channel.invokeMethod(name, arguments: parameters)
    }
}
