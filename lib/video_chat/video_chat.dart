import 'package:flutter/material.dart';
import 'package:agora_uikit/agora_uikit.dart';


class VideoChat extends StatefulWidget {
  const VideoChat({Key? key}) : super(key: key);

  @override
  State<VideoChat> createState() => _VideoChatState();
}

class _VideoChatState extends State<VideoChat> {

  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: "32d786152bdb48c8b80c054ef83ae7d5",
      channelName: "DoctorPatientVideoCall",
      tempToken: "007eJxTYNjlNLNZtPp767vAu+a2T96VV2odFp2rovrq/d+yMM39okwKDMZGKeYWZoamRkkpSSYWyRZJFgbJBqYmqWkWxomp5imm4eHfkxsCGRnOTGVjYWSAQBBfjMElP7kkvyggsSQzNa8kLDMlNd85MSeHgQEABlEm6w==",
    ),
  );
  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    await client.initialize();
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
        child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
            ),

          ),
          automaticallyImplyLeading: false,
          title: const Text('Video Call'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                client: client,
                layoutType: Layout.floating,
                showNumberOfUsers: true,
                enableHostControls: true, // Add this to enable host controls
              ),
              AgoraVideoButtons(
                client: client,
                enabledButtons: const [
                  BuiltInButtons.toggleCamera,
                  BuiltInButtons.callEnd,
                  BuiltInButtons.toggleMic,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
