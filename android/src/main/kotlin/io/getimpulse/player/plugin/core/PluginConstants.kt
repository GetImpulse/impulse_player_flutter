package io.getimpulse.player.plugin.core

@Suppress("ConstPropertyName")
internal object PluginConstants {

    const val PluginTag = "impulse-player-plugin"
    const val ViewTag = "impulse-player-view"

    object Method {
        const val Load = "load"
        const val Play = "play"
        const val Pause = "pause"
        const val Seek = "seek"
        const val GetState = "get_state"
        const val IsPlaying = "is_playing"
        const val GetProgress = "get_progress"
        const val GetDuration = "get_duration"
        const val GetError = "get_error"

        const val SetAppearance = "set_appearance"
        const val SetSettings = "set_settings"
    }

    object Parameter {
        const val PictureInPictureEnabled = "picture_in_picture_enabled"
        const val CastReceiverApplicationId = "cast_receiver_application_id"
        const val Id = "id"
        const val Url = "url"
        const val Headers = "headers"
        const val Title = "title"
        const val Subtitle = "subtitle"
        const val Time = "time"
        const val Message = "message"
    }

    object Value {
        const val Normal = "normal"
        const val Italic = "italic"
    }

    object Callback {
        const val OnReady = "on_ready"
        const val OnPlay = "on_play"
        const val OnPause = "on_pause"
        const val OnFinish = "on_ready"
        const val OnError = "on_error"
    }

    object State {
        const val Loading = "loading"
        const val Ready = "ready"
        const val Error = "error"
    }
}