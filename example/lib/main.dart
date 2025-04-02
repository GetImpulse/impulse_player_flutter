import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:impulse_player_flutter/impulse_player.dart';
import 'package:impulse_player_flutter/impulse_player_controller.dart';
import 'package:impulse_player_flutter/impulse_player_view.dart';
import 'package:impulse_player_flutter/plugin/impulse_player_plugin.dart';
import 'package:impulse_player_flutter/plugin/plugin_platform.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final ImpulsePlayerController _controller = ImpulsePlayerController(
    onReady: () async {
      print("onReady");
    },
    onPlay: () {
      print("onPlay");
    },
    onPause: () {
      print("onPause");
    },
    onFinish: () {
      print("onFinish");
    },
    onError: (message) {
      print("onError: $message");
    },
  );
  final ImpulsePlayerPlugin _plugin = ImpulsePlayerPlugin();

  @override
  void initState() {
    super.initState();
    // _controller.onPlay = () async {
    //   setState(() { });
    // };
    // _controller.onPause = () async {
    //   setState(() { });
    // };
    initPlatformState();
    _setImpulsePlayerSettings();
    _setImpulsePlayerAppearance();
    _loadVideo();
    // _controller.onReady = () async {
    //   print("onReady");
    //   await _controller.load("Title", "Subtitle", "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8");
    // };
  }

  void _setImpulsePlayerSettings() {
    ImpulsePlayer.setSettings(
        pictureInPictureEnabled: true, // Whether Picture-in-Picture is enabled; Default `false` (disabled)
        castReceiverApplicationId: "01128E51", // Cast receiver application id of the cast app; Default `null` (disabled)
    );
  }

  void _setImpulsePlayerAppearance() {
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
  }

  void _loadVideo() async {
    // await _controller.load("Title", "Subtitle", "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8");
    await _controller.load("Title", "Subtitle", "https://test-streams.mux.dev/x36xhzz/url_6/193039199_mp4_h264_aac_hq_7.m3u8");
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await ImpulsePlayerPluginPlatform.instance.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          // child: Text('Running on: $_platformVersion\n'),
          child: ListView(
            children: [
              Text('Running on: $_platformVersion\n'),
              ImpulsePlayerView(
                controller: _controller,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
