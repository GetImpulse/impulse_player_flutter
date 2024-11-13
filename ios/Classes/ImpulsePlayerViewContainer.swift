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
    
    func load(title: String?, subtitle: String?, url: String) {
        print("load")
        inner.load(title: title, subtitle: subtitle, url: URL(string: url)!)
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
        return Int64(inner.progress * 1000)
    }
    
    func getDuration() -> Int64 {
        // iOS returns a TimeInterval which is seconds with millis as decimals. Where the Flutter library expects milliseconds here.
        return Int64(inner.duration * 1000)
    }
    
    func getError() -> String? {
        return inner.error?.localizedDescription
    }
}