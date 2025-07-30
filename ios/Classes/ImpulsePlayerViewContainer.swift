import Flutter
import ImpulsePlayer

class ImpulsePlayerViewContainer: NSObject, FlutterPlatformView {
    
    let id: Int64
    private var inner: ImpulsePlayerView
    private let delegate: PlayerDelegate // Store to prevent it from being cleared
    
    init(id: Int64, delegate: PlayerDelegate) {
        guard let parent = UIApplication.shared.getRootViewController() else {
            fatalError("Missing root view controller")
        }
        self.id = id
        self.delegate = delegate
        inner = ImpulsePlayerView(parent: parent)
        inner.delegate = delegate
    }

    func view() -> UIView {
        return inner
    }
    
    func setCastEnabled(_ enabled: Bool) {
        inner.setCastEnabled(enabled)
    }
    
    func load(url: String, title: String?, subtitle: String?, headers: [String: String]) {
        inner.load(url: URL(string: url)!, title: title, subtitle: subtitle, headers: headers)
    }
    
    func play() {
        inner.play()
    }
    
    func pause() {
        inner.pause()
    }
    
    func seek(to time: Int64) {
        // The Flutter library sends milliseconds. Where iOS wants a TimeInterval (seconds with milliseconds as decimals).
        let to = Double(time) / 1000.0
        inner.seek(to: to)
    }
    
    func getState() -> String {
        switch inner.state {
        case .loading:
            PluginConstants.State.loading
        case .ready:
            PluginConstants.State.ready
        case .error:
            PluginConstants.State.error
        }
    }
    
    func isPlaying() -> Bool {
        return inner.isPlaying
    }
    
    func getProgress() -> Int64 {
        // iOS returns a TimeInterval which is seconds with millis as decimals. Where the Flutter library expects milliseconds here.
        if inner.progress.isNaN {
            return 0
        }
        return Int64(inner.progress * 1000)
    }
    
    func getDuration() -> Int64 {
        // iOS returns a TimeInterval which is seconds with millis as decimals. Where the Flutter library expects milliseconds here.
        if inner.duration.isNaN {
            return 0
        }
        return Int64(inner.duration * 1000)
    }
    
    func getError() -> String? {
        return inner.error?.localizedDescription
    }
    
    func keepAlive() {
        // No-op for iOS
    }
    
    func dispose() {
        // No-op for iOS
    }
}
