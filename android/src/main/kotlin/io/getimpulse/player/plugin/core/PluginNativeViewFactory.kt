package io.getimpulse.player.plugin.core

import android.content.Context
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.getimpulse.player.Navigator
import io.getimpulse.player.extension.ImpulsePlayerFlutter
import io.getimpulse.player.model.PlayerDelegate
import io.getimpulse.player.plugin.ImpulsePlayerViewContainer

internal class PluginNativeViewFactory(
    private val channel: MethodChannel,
    private val navigator: Navigator,
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    companion object {
        private val instances = mutableMapOf<Int, ImpulsePlayerViewContainer>()

        fun get(id: Int) = instances[id]

        fun dispose(instance: ImpulsePlayerViewContainer) {
            instances.remove(instance.id)
        }
    }

    override fun create(context: Context, id: Int, args: Any?): PlatformView {
        val instance = ImpulsePlayerViewContainer(id, context, object : PlayerDelegate {
            override fun onReady() {
                PluginCallback.OnReady.execute(channel, id)
            }

            override fun onPlay() {
                PluginCallback.OnPlay.execute(channel, id)
            }

            override fun onPause() {
                PluginCallback.OnPause.execute(channel, id)
            }

            override fun onFinish() {
                PluginCallback.OnFinish.execute(channel, id)
            }

            override fun onError(message: String) {
                PluginCallback.OnError(message).execute(channel, id)
            }
        })
        ImpulsePlayerFlutter.setNavigator(instance.view, navigator)
        instances[id] = instance
        return instance
    }
}