// import 'dart:async';
//
// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// const appId = "2851b847fb4f42f0b815e067b035e8e6";
//
// class VideoCall extends StatefulWidget {
//   final String channelName;
//
//   const VideoCall({Key? key, required this.channelName}) : super(key: key);
//   @override
//   _VideoCallState createState() => _VideoCallState();
// }
//
// class _VideoCallState extends State<VideoCall> {
//   int? _remoteUid;
//   bool _localUserJoined = false;
//   late RtcEngine _engine;
//
//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }
//
//   Future<void> initAgora() async {
//     // retrieve permissions
//     await [Permission.microphone, Permission.camera].request();
//
//     //create the engine
//     _engine = await RtcEngine.create(appId);
//     await _engine.enableVideo();
//     _engine.setEventHandler(
//       RtcEngineEventHandler(
//         joinChannelSuccess: (String channel, int uid, int elapsed) {
//           print("local user $uid joined");
//           setState(() {
//             _localUserJoined = true;
//           });
//         },
//         userJoined: (int uid, int elapsed) {
//           print("remote user $uid joined");
//           setState(() {
//             _remoteUid = uid;
//           });
//         },
//         userOffline: (int uid, UserOfflineReason reason) {
//           print("remote user $uid left channel");
//           setState(() {
//             _remoteUid = null;
//           });
//         },
//       ),
//     );
//
//     await _engine.joinChannel(null, 'testing', null, 0);
//   }
//
//   // Create UI with local view and remote view
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Agora Video Call'),
//       ),
//       body: Stack(
//         children: [
//           Center(
//             child: _remoteVideo(),
//           ),
//           Align(
//             alignment: Alignment.topLeft,
//             child: Container(
//               width: 100,
//               height: 150,
//               child: Center(
//                 child: _localUserJoined
//                     ? RtcLocalView.SurfaceView()
//                     : CircularProgressIndicator(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Display remote user's video
//   Widget _remoteVideo() {
//     if (_remoteUid != null) {
//       return RtcRemoteView.SurfaceView(uid: _remoteUid!);
//     } else {
//       return Text(
//         'Please wait for remote user to join',
//         textAlign: TextAlign.center,
//       );
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_uikit/agora_uikit.dart';

const AGORA_APP_ID = '43c82f753e0545c78a8198ed60a804f3';
String time = '';
//
// const Token =
//     '0066b462cbcdf254436ab726620f1edb93bIABuntCwp0/RdFu7vSGX7rKs7WOlQcs+nD6NrZ8Fhm5kUbIhF1sAAAAAEAD+bihbwWpMYQEAAQDCakxh';

class VideoCallPage extends StatefulWidget {
  final String channelName;

  const VideoCallPage({
    Key? key,
    required this.channelName,
  }) : super(key: key);

  @override
  _VideoCallPageState createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  late String channelname;
  late AgoraClient client;
  late DateTime date = DateTime.now();

  @override
  void dispose() async {
    print('dispose called');
    super.dispose();

    // client.sessionController.value.engine!.destroy();
    // Need to call dispose function.
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      channelname = widget.channelName;

      initialize(channelname, context);
    });
  }

  Future initialize(String channelname, BuildContext context) async {
    client = AgoraClient(
      agoraEventHandlers: AgoraEventHandlers(
        joinChannelSuccess: (v, i, j) {
          setState(() {});
        },
        userJoined: (i, j) {
          setState(() {});
        },
        leaveChannel: (v) {},
        userOffline: (i, j) {
          setState(() {});
        },
      ),
      agoraConnectionData: AgoraConnectionData(
        appId: AGORA_APP_ID,
        channelName: channelname,
      ),
      enabledPermission: [
        //RtcEngine.instance.muteLocalVideoStream(true)
        Permission.microphone,
        Permission.camera,
      ],
    );
    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                disabledVideoWidget: Center(
                    child: CircleAvatar(
                  radius: 150,
                )),
                layoutType: Layout.floating,
                client: client,
                showAVState: true,
              ),
              AgoraVideoButtons(
                client: client,
                disconnectButtonChild: MaterialButton(
                  onPressed: () {
                    setState(() {
                      client.sessionController.endCall();
                      client.sessionController.dispose();

                      Navigator.pop(context);
                    });
                  },
                  child: Icon(Icons.call_end, color: Colors.white, size: 35),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  color: Colors.redAccent,
                  padding: const EdgeInsets.all(15.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
