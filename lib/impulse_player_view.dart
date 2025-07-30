import 'package:impulse_player_flutter/impulse_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:impulse_player_flutter/plugin/impulse_player_factory.dart';

class ImpulsePlayerView extends StatefulWidget {
  final ImpulsePlayerController controller;

  const ImpulsePlayerView({
    super.key,
    required this.controller,
  });

  @override
  State<StatefulWidget> createState() => _ImpulsePlayerViewState();
}

class _ImpulsePlayerViewState extends State<ImpulsePlayerView> with AutomaticKeepAliveClientMixin {

  bool _disposed = false;

  @override
  bool get wantKeepAlive => !_disposed;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ImpulsePlayerFactory.createView(context, widget.controller)
    );
  }

  @override
  void dispose() {
    _disposed = true;
    ImpulsePlayerFactory.dispose(widget.controller);
    super.dispose();
  }
}
