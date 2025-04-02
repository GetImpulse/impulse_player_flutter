package io.getimpulse.player.plugin.core

import android.content.Context
import android.graphics.Typeface
import android.graphics.fonts.FontVariationAxis
import io.flutter.plugin.common.MethodCall
import io.getimpulse.player.ImpulsePlayer
import io.getimpulse.player.model.ImpulsePlayerAppearance
import io.getimpulse.player.model.ImpulsePlayerFont
import io.getimpulse.player.model.ImpulsePlayerSettings
import kotlin.math.roundToInt

internal sealed class PluginMethod {

    sealed class Result {
        object Executed : Result()
        data class Data<T>(val value: T) : Result()
    }

    data class Load(val id: Int, val title: String?, val subtitle: String?, val url: String) :
        PluginMethod()

    data class Play(val id: Int) : PluginMethod()
    data class Pause(val id: Int) : PluginMethod()
    data class Seek(val id: Int, val time: Long) : PluginMethod()
    data class GetState(val id: Int) : PluginMethod()
    data class IsPlaying(val id: Int) : PluginMethod()
    data class GetProgress(val id: Int) : PluginMethod()
    data class GetDuration(val id: Int) : PluginMethod()
    data class GetError(val id: Int) : PluginMethod()
    data class SetAppearance(
        val h3: ImpulsePlayerFont,
        val h4: ImpulsePlayerFont,
        val s1: ImpulsePlayerFont,
        val l4: ImpulsePlayerFont,
        val l7: ImpulsePlayerFont,
        val p1: ImpulsePlayerFont,
        val p2: ImpulsePlayerFont,
        val accentColor: Int,
    ) : PluginMethod()
    data class SetSettings(
        val pictureInPictureEnabled: Boolean,
        val castReceiverApplicationId: String?,
    ) : PluginMethod()

    fun execute(): Result = when (this) {
        is Load -> {
            PluginNativeViewFactory.get(id)?.load(title, subtitle, url)
            Result.Executed
        }

        is Play -> {
            PluginNativeViewFactory.get(id)?.play()
            Result.Executed
        }

        is Pause -> {
            PluginNativeViewFactory.get(id)?.pause()
            Result.Executed
        }

        is Seek -> {
            PluginNativeViewFactory.get(id)?.seek(time)
            Result.Executed
        }

        is GetState -> {
            val state = PluginNativeViewFactory.get(id)?.getState()
            Result.Data(state)
        }

        is IsPlaying -> {
            val playing = PluginNativeViewFactory.get(id)?.isPlaying()
            Result.Data(playing)
        }

        is GetProgress -> {
            val progress = PluginNativeViewFactory.get(id)?.getProgress()
            Result.Data(progress)
        }

        is GetDuration -> {
            val duration = PluginNativeViewFactory.get(id)?.getDuration()
            Result.Data(duration)
        }

        is GetError -> {
            val error = PluginNativeViewFactory.get(id)?.getError()
            Result.Data(error)
        }

        is SetAppearance -> {
            ImpulsePlayer.setAppearance(
                ImpulsePlayerAppearance(
                    h3, h4, s1, l4, l7, p1, p2,
                    accentColor,
                )
            )
            Result.Executed
        }

        is SetSettings -> {
            ImpulsePlayer.setSettings(
                ImpulsePlayerSettings(
                    pictureInPictureEnabled,
                    castReceiverApplicationId,
                )
            )
            Result.Executed
        }
    }

    companion object {
        fun from(call: MethodCall, context: Context?): PluginMethod? {
            val id = call.argument<Int>(PluginConstants.Parameter.Id)
            return when (call.method) {
                PluginConstants.Method.Load -> {
                    requireNotNull(id)
                    val url = call.argument<String>(PluginConstants.Parameter.Url)
                    val title = call.argument<String>(PluginConstants.Parameter.Title)
                    val description = call.argument<String>(PluginConstants.Parameter.Subtitle)
                    requireNotNull(url)
                    Load(id, title, description, url)
                }

                PluginConstants.Method.Play -> {
                    requireNotNull(id)
                    Play(id)
                }

                PluginConstants.Method.Pause -> {
                    requireNotNull(id)
                    Pause(id)
                }

                PluginConstants.Method.Seek -> {
                    requireNotNull(id)
                    val time = call.argument<Long>(PluginConstants.Parameter.Time)
                    requireNotNull(time)
                    Seek(id, time)
                }

                PluginConstants.Method.GetState -> {
                    requireNotNull(id)
                    GetState(id)
                }

                PluginConstants.Method.IsPlaying -> {
                    requireNotNull(id)
                    IsPlaying(id)
                }

                PluginConstants.Method.GetProgress -> {
                    requireNotNull(id)
                    GetProgress(id)
                }

                PluginConstants.Method.GetDuration -> {
                    requireNotNull(id)
                    GetDuration(id)
                }

                PluginConstants.Method.GetError -> {
                    requireNotNull(id)
                    GetError(id)
                }

                PluginConstants.Method.SetAppearance -> {
                    requireNotNull(context)
                    SetAppearance(
                        createFont(context, call.argument<Map<String, Any>>("h3")!!),
                        createFont(context, call.argument<Map<String, Any>>("h4")!!),
                        createFont(context, call.argument<Map<String, Any>>("s1")!!),
                        createFont(context, call.argument<Map<String, Any>>("l4")!!),
                        createFont(context, call.argument<Map<String, Any>>("l7")!!),
                        createFont(context, call.argument<Map<String, Any>>("p1")!!),
                        createFont(context, call.argument<Map<String, Any>>("p2")!!),
                        call.argument<Int>("accent_color")!!,
                    )
                }

                PluginConstants.Method.SetSettings -> {
                    val pictureInPictureEnabled = call.argument<Boolean>(PluginConstants.Parameter.PictureInPictureEnabled)
                    val castReceiverApplicationId = call.argument<String>(PluginConstants.Parameter.CastReceiverApplicationId)
                    requireNotNull(pictureInPictureEnabled)
                    SetSettings(
                        pictureInPictureEnabled,
                        castReceiverApplicationId,
                    )
                }

                else -> null
            }
        }

        private fun createFont(context: Context, json: Map<String, Any>): ImpulsePlayerFont {
            val size = (json["size"] as Double).roundToInt()
            val family = json["family"] as String
            val weight = json["weight"] as Int
            val style = json["style"] as String
            val path = when (style) {
                PluginConstants.Value.Normal -> "fonts/$family.ttf"
                PluginConstants.Value.Italic -> "fonts/$family-$style.ttf"
                else -> throw IllegalArgumentException("Unhandled style $style")
            }
            val variationWeight = FontVariationAxis("wght", weight.toFloat())
            return ImpulsePlayerFont(
                size,
                Typeface.Builder(context.assets, path)
                    .setFontVariationSettings(arrayOf(variationWeight))
                    .build()
            )
        }
    }
}