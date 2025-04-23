import UIKit
import Flutter
import ImpulsePlayer

enum PluginMethod {
    
    enum Result<T> {
        case executed
        case data(value: T)
    }
    
    case setCastEnabled(id: Int64, enabled: Bool)
    case load(id: Int64, url: String, title: String?, subtitle: String?, headers: [String:String])
    case play(id: Int64)
    case pause(id: Int64)
    case seek(id: Int64, time: Int64)
    case getState(id: Int64)
    case isPlaying(id: Int64)
    case getProgress(id: Int64)
    case getDuration(id: Int64)
    case getError(id: Int64)
    case setAppearance(h3: ImpulsePlayerFont, h4: ImpulsePlayerFont, s1: ImpulsePlayerFont, l4: ImpulsePlayerFont, l7: ImpulsePlayerFont, p1: ImpulsePlayerFont, p2: ImpulsePlayerFont, accentColor: UIColor)
    case setSettings(pictureInPictureEnabled: Bool, castReceiverApplicationId: String?)

    @MainActor func execute() -> Any? {
        switch self {
        case .setCastEnabled(let id, let enabled):
            PluginNativeViewFactory.get(id)?.setCastEnabled(enabled)
            return nil
            
        case .load(let id, let url, let title, let subtitle, let headers):
            PluginNativeViewFactory.get(id)?.load(url: url, title: title, subtitle: subtitle, headers: headers)
            return nil
            
        case .play(let id):
            PluginNativeViewFactory.get(id)?.play()
            return nil
            
        case .pause(let id):
            PluginNativeViewFactory.get(id)?.pause()
            return nil
            
        case .seek(let id, let time):
            PluginNativeViewFactory.get(id)?.seek(to: time)
            return nil
            
        case .getState(let id):
            let state = PluginNativeViewFactory.get(id)?.getState()
            return state
            
        case .isPlaying(let id):
            let playing = PluginNativeViewFactory.get(id)?.isPlaying()
            return playing
            
        case .getProgress(let id):
            let progress = PluginNativeViewFactory.get(id)?.getProgress()
            return progress
            
        case .getDuration(let id):
            let duration = PluginNativeViewFactory.get(id)?.getDuration()
            return duration
            
        case .getError(let id):
            let error = PluginNativeViewFactory.get(id)?.getError()
            return error
            
        case .setAppearance(let h3, let h4, let s1, let l4, let l7, let p1, let p2, let accentColor):
            ImpulsePlayer.setAppearance(appearance: ImpulsePlayerAppearance(
                h3: h3,
                h4: h4,
                s1: s1,
                l4: l4,
                l7: l7,
                p1: p1,
                p2: p2,
                accentColor: accentColor
            ))
            return nil
            
        case .setSettings(let pictureInPictureEnabled, let castReceiverApplicationId):
            let settings = ImpulsePlayerSettings(
                pictureInPictureEnabled: pictureInPictureEnabled,
                castReceiverApplicationId: castReceiverApplicationId
            )
            ImpulsePlayer.setSettings(settings: settings)
            return nil
        }
    }
    
    static func from(call: FlutterMethodCall) -> PluginMethod? {
        guard let arguments = call.arguments as? Dictionary<String, Any> else { return nil }
        
        let id = arguments[PluginConstants.Parameter.id] as? Int64
        switch call.method {
        case PluginConstants.Method.setCastEnabled:
            guard let id else { fatalError("Missing id") }
            guard let enabled = arguments[PluginConstants.Parameter.enabled] as? Bool else {
                return nil
            }
            return .setCastEnabled(id: id, enabled: enabled)
            
        case PluginConstants.Method.load:
            guard let id,
                  let url = arguments[PluginConstants.Parameter.url] as? String
            else {
                return nil
            }
            let title = arguments[PluginConstants.Parameter.title] as? String
            let subtitle = arguments[PluginConstants.Parameter.subtitle] as? String
            let headers = arguments[PluginConstants.Parameter.headers] as? [String: String] ?? [:]
            return .load(id: id, url: url, title: title, subtitle: subtitle, headers: headers)
            
        case PluginConstants.Method.play:
            guard let id else { fatalError("Missing id") }
            return .play(id: id)
            
        case PluginConstants.Method.pause:
            guard let id else { fatalError("Missing id") }
            return .pause(id: id)
            
        case PluginConstants.Method.seek:
            guard let id else { fatalError("Missing id") }
            guard let time = arguments[PluginConstants.Parameter.time] as? Int64 else {
                return nil
            }
            return .seek(id: id, time: time)
            
        case PluginConstants.Method.getState:
            guard let id else { fatalError("Missing id") }
            return .getState(id: id)
            
        case PluginConstants.Method.isPlaying:
            guard let id else { fatalError("Missing id") }
            return .isPlaying(id: id)
            
        case PluginConstants.Method.getProgress:
            guard let id else { fatalError("Missing id") }
            return .getProgress(id: id)
            
        case PluginConstants.Method.getDuration:
            guard let id else { fatalError("Missing id") }
            return .getDuration(id: id)
            
        case PluginConstants.Method.getError:
            guard let id else { fatalError("Missing id") }
            return .getError(id: id)
            
        case PluginConstants.Method.setAppearance:
            return .setAppearance(
                h3: createFont(json: arguments["h3"] as! [String: Any]),
                h4: createFont(json: arguments["h4"] as! [String: Any]),
                s1: createFont(json: arguments["s1"] as! [String: Any]),
                l4: createFont(json: arguments["l4"] as! [String: Any]),
                l7: createFont(json: arguments["l7"] as! [String: Any]),
                p1: createFont(json: arguments["p1"] as! [String: Any]),
                p2: createFont(json: arguments["p2"] as! [String: Any]),
                accentColor: colorFromInt64(argb: arguments["accent_color"] as! Int64)
            )
            
        case PluginConstants.Method.setSettings:
            guard let pictureInPictureEnabled = arguments[PluginConstants.Parameter.pictureInPictureEnabled] as? Bool else {
                return nil
            }
            let castReceiverApplicationId = arguments[PluginConstants.Parameter.castReceiverApplicationId] as? String
            return .setSettings(
                pictureInPictureEnabled: pictureInPictureEnabled,
                castReceiverApplicationId: castReceiverApplicationId
            )
            
        default:
            return nil
        }
    }
    
    private static func createFont(json: [String: Any]) -> ImpulsePlayerFont {
        let size = json["size"] as! CGFloat
        let family = json["family"] as! String
        let weight = json["weight"] as! CGFloat
        let style = json["style"] as! String
        let bold = weight >= 500
        let italic = style == PluginConstants.Value.italic
        return ImpulsePlayerFont(
            fontType: .customByFamily(familyName: family, bold: bold, italic: italic),
            size: size
        )
    }
    
    private static func colorFromInt64(argb: Int64) -> UIColor {
        let alpha = CGFloat((argb >> 24) & 0xFF) / 255.0
        let red = CGFloat((argb >> 16) & 0xFF) / 255.0
        let green = CGFloat((argb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(argb & 0xFF) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
