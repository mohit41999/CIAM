import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/chatMessages.dart';
import 'package:patient/Screens/video_player.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/commonAppBarLeading.dart';

class TextPage extends StatefulWidget {
  final String doctorid;
  final String doctorName;
  const TextPage({Key? key, required this.doctorid, required this.doctorName})
      : super(key: key);

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  Future<void> sendmessage(BuildContext context, String message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(message);
    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        'Enter some Text',
      )));
    } else {
      await PostData(PARAM_URL: 'add_patient_chat.php', params: {
        'token': Token,
        'user_id': prefs.getString('user_id'),
        'doctor_id': widget.doctorid,
        'msg_type': 'm',
        'message': message,
      }).then((value) {
        if (value['status']) {
          messagecontroller.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value['message']),
            duration: Duration(seconds: 1),
          ));
        }
      });
    }
  }

  Future<void> sendmessagewithImage(
      BuildContext context, String message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(message);
    await PostDataWithImage(
            PARAM_URL: 'add_patient_chat.php',
            params: {
              'token': Token,
              'user_id': prefs.getString('user_id')!,
              'doctor_id': widget.doctorid,
              'msg_type': 'i',
              'message': message,
            },
            imageparamName: 'image',
            imagePath: mediaFile!.path)
        .then((value) {
      if (value['status']) {
        messagecontroller.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value['message']),
          duration: Duration(seconds: 1),
        ));
      }
    });
  }

  Future<void> sendmessagewithvideo(
      BuildContext context, String message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(message);
    await PostDataWithImage(
            PARAM_URL: 'add_patient_chat.php',
            params: {
              'token': Token,
              'user_id': prefs.getString('user_id')!,
              'doctor_id': widget.doctorid,
              'msg_type': 'v',
              'message': message,
            },
            imageparamName: 'video',
            imagePath: video!.path)
        .then((value) {
      if (value['status']) {
        messagecontroller.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value['message']),
          duration: Duration(seconds: 1),
        ));
      }
    });
  }

  Future<ChatMessages> getChats(BuildContext context) async {
    late Map<String, dynamic> response;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await PostData(PARAM_URL: 'get_chat_messages.php', params: {
      'token': Token,
      'user_id': prefs.getString('user_id'),
      'doctor_id': widget.doctorid,
    }).then((value) {
      if (value['status']) {
        response = value;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value['message']),
          duration: Duration(seconds: 1),
        ));
      }
    });
    return ChatMessages.fromJson(response);
  }

  late ChatMessages chatMessages;

  TextEditingController messagecontroller = TextEditingController();

  void initializechats() {
    getChats(context).then((value) {
      setState(() {
        chatMessages = value;
        loading = false;
      });
    });
  }

  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          print('5 secs');
          initializechats();
        });
      }
    });
  }

  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                color: Colors.black,
                height: 1.0,
              ),
            ),
            preferredSize: Size.fromHeight(1.0)),
        title: commonAppBarTitleText(appbarText: widget.doctorName),
        centerTitle: true,
        backgroundColor: appAppBarColor,
        elevation: 0,
        leading: Builder(
            builder: (context) => commonAppBarLeading(
                iconData: Icons.arrow_back_ios_new,
                onPressed: () {
                  Navigator.pop(context);
                })),
      ),
      body: (loading)
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    reverse: true,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: chatMessages.data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              MessageTile(
                                video: chatMessages.data[index].chatVideo,
                                image: chatMessages.data[index].chatImage,
                                message: chatMessages.data[index].message,
                                sendByMe: chatMessages.data[index].sendBy ==
                                    'patient',
                              ),
                              (index == chatMessages.data.length - 1)
                                  ? SizedBox(
                                      height: 80,
                                    )
                                  : Container()
                            ],
                          );
                        }),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        // padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        color: apptealColor,
                        child: Row(
                          children: [
                            GestureDetector(
                              child: Container(
                                  height: 48,
                                  width: 50,
                                  color: apptealColor,
                                  child: Icon(Icons.add, color: Colors.white)),
                              onTap: () {
                                _showoptionPicker(context);
                                // print(messagecontroller.text.toString());

                                //sendMessage();
                              },
                            ),
                            Container(
                              height: 48,
                              width: 1.5,
                              color: Colors.white,
                            ),
                            Expanded(
                                child: Container(
                                    color: apptealColor,
                                    //height: 30,
                                    child: TextField(
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 50,
                                      minLines: 1,
                                      controller: messagecontroller,
                                      decoration: InputDecoration(
                                          hintText: 'Write message here.....',
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                          contentPadding: EdgeInsets.all(10),
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none),
                                      // controller: _controller,
                                    ))),
                            Container(
                              height: 48,
                              width: 1.5,
                              color: Colors.white,
                            ),
                            GestureDetector(
                              child: Container(
                                  height: 48,
                                  width: 50,
                                  color: apptealColor,
                                  child: Icon(Icons.send, color: Colors.white)),
                              onTap: () {
                                // print(messagecontroller.text.toString());
                                sendmessage(
                                    context, messagecontroller.text.toString());
                                //sendMessage();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _showPicker(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(
                        Icons.photo_library,
                        color: Colors.red,
                      ),
                      title: Text('Photo Library'),
                      onTap: () {
                        setState(() {
                          _imgFromGallery();
                        });

                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(
                      Icons.photo_camera,
                      color: Colors.red,
                    ),
                    title: Text('Camera'),
                    onTap: () {
                      setState(() {
                        _imgFromCamera();
                      });

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showoptionPicker(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(
                        Icons.photo_camera,
                        color: appblueColor,
                      ),
                      title: Text('Photo'),
                      onTap: () {
                        setState(() {
                          Navigator.of(context).pop();
                          _showPicker(context);
                        });
                      }),
                  ListTile(
                    leading: Icon(
                      Icons.videocam,
                      color: apptealColor,
                    ),
                    title: Text('Video'),
                    onTap: () {
                      setState(() {
                        Navigator.of(context).pop();
                        _showVideoPicker(context);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  XFile? mediaFile = null;
  Future _imgFromCamera() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      mediaFile = image;
      sendmessagewithImage(context, '').then((value) {
        setState(() {
          mediaFile = null;
        });
      });
    });
  }

  Future _imgFromGallery() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      mediaFile = image;
      sendmessagewithImage(context, '').then((value) {
        setState(() {
          mediaFile = null;
        });
      });
    });
  }

  Future<void> _showVideoPicker(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(
                        Icons.photo_library,
                        color: Colors.blue,
                      ),
                      title: Text('Photo Library'),
                      onTap: () {
                        setState(() {
                          _vidFromGallery();
                        });

                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(
                      Icons.photo_camera,
                      color: Colors.blue,
                    ),
                    title: Text('Camera'),
                    onTap: () {
                      setState(() {
                        _vidFromCamera();
                      });

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  XFile? video = null;
  Future _vidFromCamera() async {
    var image = await ImagePicker().pickVideo(source: ImageSource.camera);

    setState(() {
      video = image;
      sendmessagewithvideo(context, '').then((value) {
        setState(() {
          video = null;
        });
      });
    });
  }

  Future _vidFromGallery() async {
    var image = await ImagePicker().pickVideo(source: ImageSource.gallery);

    setState(() {
      video = image;
      sendmessagewithvideo(context, '').then((value) {
        setState(() {
          video = null;
        });
      });
    });
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final String video;
  final String image;
  final bool sendByMe;

  MessageTile(
      {required this.message,
      required this.sendByMe,
      required this.image,
      required this.video});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    bottomRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe
                  ? [
                      const Color(0xff150050).withOpacity(0.57),
                      const Color(0xff150050).withOpacity(0.57),
                    ]
                  : [const Color(0xff9B9B9B), const Color(0xff9B9B9B)],
            )),
        child: (image == '')
            ? (video == '')
                ? Text(message,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'OverpassRegular',
                        fontWeight: FontWeight.w300))
                : GestureDetector(
                    onTap: () {
                      Push(
                          context,
                          VideoPlay(
                              video: video.toString().replaceAll(
                                  'http://ciam.notionprojects.tech/assets/uploaded/chatvideos/',
                                  ''),
                              url: video),
                          withnav: false);
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Icon(
                        Icons.play_circle_outlined,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                  )
            : Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.contain)),
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width / 4,
                // child: Image.network(image)
              ),
      ),
    );
  }
}
