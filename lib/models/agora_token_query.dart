import 'dart:convert';

class AgoraTokenQuery {
  final String token;
  final String user_role_id;
  final String? channelName;

  AgoraTokenQuery({
    required this.token,
    required this.user_role_id,
    this.channelName,
  });
  AgoraTokenQuery copyWith({
    String? token,
    String? user_role_id,
    String? chanelName,
  }) {
    return AgoraTokenQuery(
      token: token ?? this.token,
      user_role_id: user_role_id ?? this.user_role_id,
      channelName: chanelName ?? this.channelName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'user_role_id': user_role_id,
      'chanelName': channelName,
    };
  }

  factory AgoraTokenQuery.fromMap(Map<String, dynamic> map) {
    return AgoraTokenQuery(
      token: map['token'],
      user_role_id: map['user_role_id'],
      channelName: map['chanelName'],
    );
  }
  String toJson() => json.encode(toMap());
  factory AgoraTokenQuery.fromJson(String source) =>
      AgoraTokenQuery.fromMap(json.decode(source));
  @override
  String toString() =>
      'AgoraTokenQuery(token: $token, user_role_id: $user_role_id, chanelName: $channelName)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AgoraTokenQuery &&
        other.token == token &&
        other.user_role_id == user_role_id &&
        other.channelName == channelName;
  }

  @override
  int get hashCode =>
      token.hashCode ^ user_role_id.hashCode ^ channelName.hashCode;
}
