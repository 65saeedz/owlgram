import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

class CallPage extends StatefulWidget {
  final RtcEngine agoraEngine;
  final int uid;
  final int? remoteUid;
  final String? channelId;

  const CallPage({
    required this.agoraEngine,
    required this.uid,
    this.remoteUid,
    this.channelId,
  }) : super();

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  int? _remoteUid;
  RtcConnection? _remoteConnection;

  @override
  void initState() {
    widget.agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onUserJoined: (connection, remoteUid, elapsed) {
          setState(() {
            _remoteUid = remoteUid;
            _remoteConnection = connection;
          });
        },
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Call Page'),
        ),
        body: Column(
          children: [
            Container(
              height: 240,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Center(
                child: _localPreview(),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 240,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Center(
                child: _remoteVideo(),
              ),
            ),
            // Button Row ends
          ],
        ));
  }

  Widget _localPreview() {
    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: widget.agoraEngine,
        canvas: VideoCanvas(
          sourceType: VideoSourceType.videoSourceCameraPrimary,
          uid: widget.uid,
        ),
      ),
    );
  }

  Widget _remoteVideo() {
    if (widget.remoteUid != null && widget.channelId != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: widget.agoraEngine,
          canvas: VideoCanvas(
            sourceType: VideoSourceType.videoSourceCameraPrimary,
            uid: widget.remoteUid!,
          ),
          connection: RtcConnection(
            channelId: widget.channelId!,
          ),
        ),
      );
    } else {
      if (_remoteUid != null && _remoteConnection != null) {
        return AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine: widget.agoraEngine,
            canvas: VideoCanvas(
              sourceType: VideoSourceType.videoSourceCameraPrimary,
              uid: _remoteUid!,
            ),
            connection: _remoteConnection!,
          ),
        );
      } else {
        return Text(
          'Waiting for peer',
          textAlign: TextAlign.center,
        );
      }
    }
  }
}
