// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

// Project imports:
import 'package:drop_go_smartphone/features/saved_file/presentation/widgets/custom_control.dart';

class VideoPreview extends StatefulWidget {
  const VideoPreview({super.key, required Map<String, Object> file})
      : _file = file;

  final Map<String, Object> _file;

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late FlickManager _flickManager;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    final path = File(widget._file['path'].toString());
    _flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.file(path),
    );
  }

  @override
  void dispose() {
    _flickManager.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        color: Colors.black87,
        child: SafeArea(
          top: false,
          child: Scaffold(
            body: Stack(
              children: [
                Center(
                  child: FlickVideoPlayer(
                    flickManager: _flickManager,
                    systemUIOverlay: const [],
                    flickVideoWithControls: const FlickVideoWithControls(
                      backgroundColor: Colors.black87,
                      videoFit: BoxFit.fitWidth,
                      controls: CustomControl(),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 20,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                    ),
                    child: FloatingActionButton(
                      heroTag: "close",
                      backgroundColor: Colors.white.withOpacity(0.5),
                      elevation: 0,
                      onPressed: () => Navigator.of(context).pop(),
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
