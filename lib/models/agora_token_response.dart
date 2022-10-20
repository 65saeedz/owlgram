import 'dart:convert';

class AgoraTokenResponse {
  final String channelName;
  final String token;

  AgoraTokenResponse({
    required this.channelName,
    required this.token,
  });
  AgoraTokenResponse copyWith({
    String? chanelName,
    String? token,
  }) {
    return AgoraTokenResponse(
      channelName: chanelName ?? this.channelName,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chanelName': channelName,
      'token': token,
    };
  }

  factory AgoraTokenResponse.fromMap(Map<String, dynamic> map) {
    return AgoraTokenResponse(
      channelName: map['chanelName'],
      token: map['token'],
    );
  }
  String toJson() => json.encode(toMap());
  factory AgoraTokenResponse.fromJson(String source) =>
      AgoraTokenResponse.fromMap(json.decode(source));
  @override
  String toString() =>
      'AgoraTokenResponse(chanelName: $channelName, token: $token)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AgoraTokenResponse &&
        other.channelName == channelName &&
        other.token == token;
  }

  @override
  int get hashCode => channelName.hashCode ^ token.hashCode;
}
