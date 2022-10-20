import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_agora/clients/http_client.dart';
import 'package:test_agora/models/agora_token_query.dart';

class AgoraClient {
  final httpClient = HttpClient();

  Future<RtcEngine> makeCall({
    required String userId,
    required String userToken,
    required String peerId,
  }) async {
    final agoraTokenResponse = await httpClient.fetchAgoraToken(
      AgoraTokenQuery(
        token: userToken,
        user_role_id: peerId,
      ),
    );

    await [
      Permission.microphone,
      Permission.camera,
    ].request();

    final agoraEngine = await _joinChannel(
      channelId: agoraTokenResponse.channelName,
      token: agoraTokenResponse.token,
      uid: int.parse(userId),
    );
    return agoraEngine;
  }

  Future<RtcEngine> receiveCall({
    required String userId,
    required String userToken,
    required String peerId,
    required String channelName,
  }) async {
    final agoraTokenResponse = await httpClient.fetchAgoraToken(
      AgoraTokenQuery(
        token: userToken,
        user_role_id: peerId,
        channelName: channelName,
      ),
    );

    await [
      Permission.microphone,
      Permission.camera,
    ].request();

    final agoraEngine = await _joinChannel(
      channelId: channelName,
      token: agoraTokenResponse.token,
      uid: int.parse(userId),
    );
    return agoraEngine;
  }

  Future<RtcEngine> _joinChannel({
    required String channelId,
    required String token,
    required int uid,
  }) async {
    final agoraAppId = 'a5b85475a1e34748a324db9d58622d98';

    final agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(
      RtcEngineContext(appId: agoraAppId),
    );
    await agoraEngine.enableVideo();

    await agoraEngine.startPreview(
      sourceType: VideoSourceType.videoSourceCameraPrimary,
    );
    await agoraEngine.joinChannel(
      channelId: channelId,
      token: token,
      uid: uid,
      options: ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileCommunication,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );

    return agoraEngine;
  }
}
