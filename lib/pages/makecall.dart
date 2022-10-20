import 'package:flutter/material.dart';
import 'package:test_agora/clients/agora_client.dart';
import 'package:test_agora/pages/call_page.dart';

class MakeCall extends StatefulWidget {
  const MakeCall({super.key});

  @override
  State<MakeCall> createState() => _MakeCallState();
}

class _MakeCallState extends State<MakeCall> {
  String userID = '';
  String userToken = '';
  String peerID = '';
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
            SizedBox(
              height: 50,
            ),
            FloatingActionButton(
              onPressed: () async {
                final agoraEngine = await AgoraClient().makeCall(
                  peerId: '90',
                  userId: '76',
                  userToken:
                      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo3NiwidXNlcl9yb2xlX2lkIjo3NiwibGFuZ3VhZ2Vfc2l0X2lkIjoiMSIsImxhbmd1YWdlX3VzZXJfaWQiOiI2IiwiaWF0IjoxNjY2MTM3NTUzLCJleHAiOjE2Njk3Mzc1NTN9.kC_14xyskidUVs6A7OFK0YMn11WzWQzVLN1lS7CFDOI',
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CallPage(
                      agoraEngine: agoraEngine,
                      uid: int.parse('76'),
                    ),
                  ),
                );
              },
              child: Text(
                'call',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
