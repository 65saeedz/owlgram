import 'package:flutter/material.dart';
import 'package:test_agora/pages/call_page.dart';

import '../clients/agora_client.dart';

class ReciveCall extends StatefulWidget {
  const ReciveCall({super.key});

  @override
  State<ReciveCall> createState() => _ReciveCallState();
}

class _ReciveCallState extends State<ReciveCall> {
  String userID = '';
  String userToken = '';
  String peerID = '';
  String chanelName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'user id'),
              onChanged: (value) {
                userID = value;
              },
            ),
            TextField(
              // keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'user token'),
              onChanged: (value) {
                userToken = value;
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'peer id'),
              onChanged: (value) {
                peerID = value;
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: 'chanel name'),
              onChanged: (value) {
                chanelName = value;
              },
            ),
            SizedBox(
              height: 50,
            ),
            FloatingActionButton(
              onPressed: () async {
                final agoraEngine = await AgoraClient().receiveCall(
                  userId: '90',
                  userToken: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo5MCwidXNlcl9yb2xlX2lkIjo5MCwibGFuZ3VhZ2Vfc2l0X2lkIjoiMSIsImxhbmd1YWdlX3VzZXJfaWQiOm51bGwsImlhdCI6MTY2NjI1MzU3OSwiZXhwIjoxNjY5ODUzNTc5fQ.QXAN3GakqW-xXX5_dvxnsrhrUfZ6aRUPMOVM08Utz54',
                  peerId: '76',
                  channelName: 'chat_76',
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CallPage(
                      agoraEngine: agoraEngine,
                      uid: int.parse('90'),
                      remoteUid: int.parse('76'),
                      channelId: 'chat_76',
                    ),
                  ),
                );
              },
              child: Text(
                'Recive',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
