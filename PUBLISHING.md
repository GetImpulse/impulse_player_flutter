# Publishing

In order to publish, several checks should be done.

## Package

- [ ] Ensure `pubspec.yaml` has the correct version.
- [ ] Ensure `CHANGELOG.md` is updated.
- [ ] Ensure `README.md` is updated.

## Android

- [ ] Ensure `android/build.gradle` contains the correct version of the Android library.

## iOS

- [ ] Ensure `example/ios/Podfile` enabled the remote reference.
- [ ] Ensure `ios/impulse_player_flutter.podspec` contains the correct version of the iOS library.

## Example

- [ ] Ensure `example/pubspec.yaml` contains the correct version.

## Publish

- [ ] `dart pub publish`