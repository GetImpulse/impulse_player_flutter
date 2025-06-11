import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:impulse_player_flutter/impulse_player.dart';
import 'package:impulse_player_flutter/impulse_player_controller.dart';
import 'package:impulse_player_flutter/impulse_player_view.dart';
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

  final ImpulsePlayerController _controller2 = ImpulsePlayerController();
  final ImpulsePlayerController _controller3 = ImpulsePlayerController();
  final ImpulsePlayerController _controller4 = ImpulsePlayerController();

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
    _controller.setCastEnabled(true);
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
    const headers = <String, String>{
      'key': 'value',
    };
    await _controller.load("https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8"); // Big Buck Bunny (Blender Foundation)
    await _controller2.load("https://origin.broadpeak.io/bpk-vod/voddemo/hlsv4/5min/sintel/index.m3u8", title: "Sintel", subtitle: "Blender Foundation"); 
    await _controller3.load("https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8", title: "Tears of Steel", subtitle: "Blender Foundation", headers: headers);
    await _controller4.load("https://webuildapps.com");
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
              const Text('Big Buck Bunny\n(Blender Foundation)\n'),
              ImpulsePlayerView(
                controller: _controller,
              ),
              const Text('\nSintel\n(Blender Foundation)\n'),
              ImpulsePlayerView(
                controller: _controller2,
              ),
              const Text('\nTears of Steel\n(Blender Foundation)\n'),
              ImpulsePlayerView(
                controller: _controller3,
              ),
              const Text('\nNo video\n'),
              const Text('(Showing failed state)\n'),
              ImpulsePlayerView(
                controller: _controller4,
              ),
              Text('\nRunning on: $_platformVersion\n'),
              // Text('Running on: $_platformVersion\n'),
              // Text('Running on: $_platformVersion\n'),
              // Text('Running on: $_platformVersion\n'),
              // Text('Running on: $_platformVersion\n'),
              // Text('Running on: $_platformVersion\n'),
              // Text('Running on: $_platformVersion\n'),
              // Text('Running on: $_platformVersion\n'),
              // Text('Running on: $_platformVersion\n'),
              // Text('Running on: $_platformVersion\n'),
              // Text('Running on: $_platformVersion\n'),
              // Text('Running on: $_platformVersion\n'),
              // Text('Running on: $_platformVersion\n'),
              // Text('Running on: $_platformVersion\n'),
              // Text('Running on: $_platformVersion\n'),
              // Text('Running on: $_platformVersion\n'),
              // Text('Running on: $_platformVersion\n'),
              // Text('Running on: $_platformVersion\n'),
              // Text('Running on: $_platformVersion\n'),
              // Text('Running on: $_platformVersion\n'),
              // Text('Running on: $_platformVersion\n'),
              // Text('Running on: $_platformVersion\n'),
            ],
          ),
        ),
      ),
    );
  }
}
