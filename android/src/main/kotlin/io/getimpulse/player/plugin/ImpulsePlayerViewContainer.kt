package io.getimpulse.player.plugin

import android.content.Context
import android.view.View
import io.flutter.plugin.platform.PlatformView
import io.getimpulse.player.ImpulsePlayerView
import io.getimpulse.player.model.PlayerDelegate
import io.getimpulse.player.model.PlayerState
import io.getimpulse.player.plugin.core.PluginConstants
import io.getimpulse.player.plugin.core.PluginNativeViewFactory
import io.getimpulse.player.util.ImpulsePlayerFlutter

internal class ImpulsePlayerViewContainer(
    val id: Int,
    context: Context,
    private val delegate: PlayerDelegate,
) : PlatformView {

    private val inner by lazy {
        ImpulsePlayerView(context).apply {
            setDelegate(delegate)
        }
    }

    override fun getView() = inner

    fun setCastEnabled(enabled: Boolean) {
        inner.setCastEnabled(enabled)
    }

    fun load(url: String, title: String?, subtitle: String?, headers: Map<String, String>) {
        inner.load(url, title, subtitle, headers)
    }

    fun play() {
        inner.play()
    }

    fun pause() {
        inner.pause()
    }

    fun seek(time: Long) {
        inner.seek(time)
    }

    fun getState(): String {
        return when (inner.getState().value) {
            PlayerState.Loading -> PluginConstants.State.Loading
            PlayerState.Ready -> PluginConstants.State.Ready
            is PlayerState.Error -> PluginConstants.State.Error
        }
    }

    fun isPlaying(): Boolean {
        return inner.isPlaying().value
    }

    fun getProgress(): Long {
        return inner.getProgress().value
    }

    fun getDuration(): Long {
        return inner.getDuration().value
    }

    fun getError(): String? {
        return inner.getError().value
    }

    override fun dispose() {
        println("dispose")
        PluginNativeViewFactory.dispose(this)
    }

    override fun onFlutterViewAttached(flutterView: View) {
        println("onFlutterViewAttached")
        super.onFlutterViewAttached(flutterView)
//        ImpulsePlayerFlutter.externalAttach(inner)
    }

    override fun onFlutterViewDetached() {
        println("onFlutterViewDetached")
//        ImpulsePlayerFlutter.externalDetach(inner)
        super.onFlutterViewDetached()
    }
}