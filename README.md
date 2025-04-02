# Impulse Player

The Impulse Player makes using a video player in Flutter easy. Under the hood, the Impulse Player uses [Impulse Player Android](https://github.com/getimpulse/impulse_player_android) and [Impulse Player iOS](https://github.com/getimpulse/impulse_player_ios).

Additionally the Impulse Player contains features such as Fullscreen handling out of the box.

Features:

- Single view to show and handle the player.
- Playback quality selection.
- Playback speed selection.
- Fullscreen handling.
- Picture-in-Picture handling.
- Support for casting.

## Installing

### Flutter

In root `pubspec.yaml`:

```dart
  impulse_player: ^0.2.0 # Remote
```

### Android

In `android/build.gradle`:

```groovy
allprojects {
    repositories {
        // ...
        maven { url "https://jitpack.io" }
    }
}
```

### iOS

In `ios/Podfile`:

```ruby
pod 'impulse_player_ios', :git => 'https://github.com/getimpulse/impulse_player_ios.git'
```

> **Note**: When not using the latest version, `, :tag =>'x.x.x'` should be added here as well. This prevents it from using the latest version, but adds maintenance in that it should be updated accordingly when updating the Impulse Player.

## Usage

Create the controller:

```dart
final ImpulsePlayerController _controller = ImpulsePlayerController();
```

Use the ImpulsePlayerView widget with the created controller.

```dart
ImpulsePlayerView(
    controller: _controller,
),
```

### Commands

The main commands to use the player:

```dart
_controller.load(
    "Title",
    "Subtitle",
    "url",
)
_controller.play()
_controller.pause()
_controller.seek(0)
```

### Getters

The values exposed by the player.

```dart
_controller.isPlaying() // Boolean, default `false`
_controller.getState() // PlayerState, default `Loading`
_controller.getProgress() // int, default `0`
_controller.getDuration() // int, default `0`
_controller.getError() // String?, default `null`
```

### Delegate

Listening to events from the player.

```dart
final ImpulsePlayerController _controller = ImpulsePlayerController(
onReady: () async {
    print("ImpulsePlayer: onReady");
},
onPlay: () {
    print("ImpulsePlayer: onPlay");
},
onPause: () {
    print("ImpulsePlayer: onPause");
},
onFinish: () {
    print("ImpulsePlayer: onFinish");
},
onError: (message) {
    print("ImpulsePlayer: onError: $message");
},
);
```

Alternatively, each callback can be set anytime directly via the controller, such as:

```dart
_controller.onReady = () async {
   print("ImpulsePlayer: onReady");
   await _controller.load("Title", "Subtitle", "url");
};
```

### Settings

Features can be enabled or disabled based on the settings. The defaults can be changed as follows:

```dart
ImpulsePlayer.setSettings(
    pictureInPictureEnabled: true, // Whether Picture-in-Picture is enabled; Default `false` (disabled)
    castReceiverApplicationId: "01128E51", // Cast receiver application id of the cast app; Default `null` (disabled)
);
```

> **Note (iOS)**: To enable Picture-in-Picture mode, add the **'Background Modes'** capability in the Runner target's project settings and enable **'Audio, AirPlay, and Picture in Picture'**.

> **Note (iOS)**: Setting up Chromecast with a custom receiver application ID requires additional configuration. On the iOS Runner target, apply the instructions described in the [iOS repository: Chromecast setup](https://github.com/GetImpulse/impulse_player_ios#chromecast-setup).

### Customization

Apply a custom appearance to customize the look of the player.

```dart
ImpulsePlayer.setAppearance(
    h3: const TextStyle(fontSize: 16, fontFamily: "Inter", fontWeight: FontWeight.w600),
    h4: const TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w600),
    s1: const TextStyle(fontSize: 12, fontFamily: "Inter", fontWeight: FontWeight.w400),
    l4: const TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w400),
    l7: const TextStyle(fontSize: 10, fontFamily: "Inter", fontWeight: FontWeight.w400),
    p1: const TextStyle(fontSize: 16, fontFamily: "Inter", fontWeight: FontWeight.w400),
    p2: const TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w400),
    accentColor: const Color(0xFF4945FF),
);
```

**Note**: To use custom fonts its required to also add the fonts to the Android and iOS project. Otherwise the custom fonts will not work within the Impulse Player.

**Android**:

- Inside the `assets` folder, create a `fonts` folder if that doesn't exist yet.
- Put the fonts in there as regular:  `<familyName>.ttf` and italic: `<familyName>-<style>.ttf`. For example when using the `Inter` font. The files will be:
  - `Inter.ttf`
  - `Inter-Italic.ttf`

**iOS**:

**Note**: Due to how Fonts are setup in iOS, using other weights than regular/bold from flutter to iOS is not possible. Therefore weights up to 500 is determined to be **regular** and from weight 500 and above it is determined **bold**.

- Add the font files to the project.
- In the `Info.plist` add the fonts to the `Fonts provided by application` key. These values should match the exact file name, including the extension.
