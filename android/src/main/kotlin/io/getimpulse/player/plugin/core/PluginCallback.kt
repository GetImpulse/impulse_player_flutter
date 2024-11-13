package io.getimpulse.player.plugin.core

import io.flutter.plugin.common.MethodChannel

internal sealed class PluginCallback(private val name: String) {

    object OnReady : PluginCallback(PluginConstants.Callback.OnReady)
    object OnPlay : PluginCallback(PluginConstants.Callback.OnPlay)
    object OnPause : PluginCallback(PluginConstants.Callback.OnPause)
    object OnFinish : PluginCallback(PluginConstants.Callback.OnFinish)
    data class OnError(val message: String) : PluginCallback(PluginConstants.Callback.OnError)

    fun execute(channel: MethodChannel, id: Int) {
        channel.invokeMethod(
            name,
            mapOf(
                // Common
                PluginConstants.Parameter.Id to id,
            ) + when (this) {
                is OnReady,
                is OnPlay,
                is OnPause,
                is OnFinish -> {
                    mapOf() // Nothing additional
                }

                is OnError -> {
                    mapOf(
                        PluginConstants.Parameter.Message to message,
                    )
                }
            }
        )
    }
}