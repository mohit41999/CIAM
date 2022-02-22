import 'dart:async';

import 'package:flutter/material.dart';
import 'package:patient/Models/chatMessages.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API repo/api_constants.dart';

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
                        height: 60,
                        // padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        color: apptealColor,
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                                    color: apptealColor,
                                    //height: 30,
                                    child: TextField(
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
                                sendmessage(context, messagecontroller.text);
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
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({required this.message, required this.sendByMe});

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
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
