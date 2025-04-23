internal enum PluginConstants {
    static let pluginTag = "impulse-player-plugin"
    static let viewTag = "impulse-player-view"

    enum Method {
        static let load = "load"
        static let play = "play"
        static let pause = "pause"
        static let seek = "seek"
        static let getState = "get_state"
        static let isPlaying = "is_playing"
        static let getProgress = "get_progress"
        static let getDuration = "get_duration"
        static let getError = "get_error"
        
        static let setAppearance = "set_appearance"
        static let setSettings = "set_settings"
    }
    
    enum Parameter {
        static let pictureInPictureEnabled = "picture_in_picture_enabled"
        static let castReceiverApplicationId = "cast_receiver_application_id"
        static let id = "id"
        static let url = "url"
        static let title = "title"
        static let subtitle = "subtitle"
        static let headers = "headers"
        static let time = "time"
        static let message = "message"
    }
    
    enum Value {
        static let normal = "normal"
        static let italic = "italic"
    }

    enum Callback {
        static let onReady = "on_ready"
        static let onPlay = "on_play"
        static let onPause = "on_pause"
        static let onFinish = "on_finish"
        static let onError = "on_error"
    }

    enum State {
        static let loading = "loading"
        static let ready = "ready"
        static let error = "error"
    }
}
