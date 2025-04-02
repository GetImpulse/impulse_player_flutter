package io.getimpulse.player.plugin

import android.app.Activity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.getimpulse.player.ImpulsePlayer
import io.getimpulse.player.model.ImpulsePlayerSettings
import io.getimpulse.player.plugin.core.PluginConstants
import io.getimpulse.player.plugin.core.PluginMethod
import io.getimpulse.player.plugin.core.PluginNativeViewFactory
import io.getimpulse.player.util.ImpulsePlayerNavigator

class ImpulsePlayerPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    private var currentActivity: Activity? = null

    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, PluginConstants.PluginTag)
        channel.setMethodCallHandler(this)

        binding.platformViewRegistry.registerViewFactory(
            PluginConstants.ViewTag,
            PluginNativeViewFactory(
                channel,
                object : ImpulsePlayerNavigator {
                    override fun getCurrentActivity() = requireNotNull(currentActivity)
                })
        )
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        println("onMethodCall ${call.method}")
        val method = PluginMethod.from(call, currentActivity)
        if (method == null) {
            when (call.method) {
                "getPlatformVersion" -> {
                    println("getPlatformVersion")
                    result.success("Android ${android.os.Build.VERSION.RELEASE}")
                }

                else -> {
                    println("not implemented")
                    result.notImplemented()
                }
            }
        } else {
            println("impulse implemented")
            result.success(
                when (val response = method.execute()) {
                    PluginMethod.Result.Executed -> null
                    is PluginMethod.Result.Data<*> -> response.value
                }
            )
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        println("onAttachedToActivity")
        currentActivity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        println("onDetachedFromActivityForConfigChanges")
        currentActivity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        println("onReattachedToActivityForConfigChanges")
        currentActivity = binding.activity
    }

    override fun onDetachedFromActivity() {
        println("onDetachedFromActivity")
        currentActivity = null
    }
}
