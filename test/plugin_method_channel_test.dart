import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impulse_player_flutter/plugin/impulse_player_plugin_constants.dart';
import 'package:impulse_player_flutter/plugin/plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelPlugin platform = MethodChannelPlugin();
  const MethodChannel channel = MethodChannel(ImpulsePlayerPluginConstants.PluginTag);

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
