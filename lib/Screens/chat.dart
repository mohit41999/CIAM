import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/firebase/database.dart';
import 'package:patient/helper/constants.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';

class Chat extends StatefulWidget {
  final String doctorID;

  Chat({required this.doctorID});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();

  Widget chatMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? SingleChildScrollView(
                reverse: true,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          MessageTile(
                            message: snapshot.data!.docs[index]["message"],
                            sendByMe: Constants.myName ==
                                snapshot.data!.docs[index]["sendBy"],
                          ),
                          (index == snapshot.data!.docs.length - 1)
                              ? SizedBox(
                                  height: 80,
                                )
                              : Container()
                        ],
                      );
                    }),
              )
            : Container();
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": Constants.myName,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseMethods().addMessage(widget.doctorID, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  @override
  void initState() {
    DatabaseMethods().getChats(widget.doctorID).then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
  }

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
        title: commonAppBarTitleText(
            appbarText: widget.doctorID
                .toString()
                .replaceAll("_", "")
                .replaceAll(Constants.myName, "")),
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
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
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
                                controller: messageEditingController,
                                decoration: InputDecoration(
                                    hintText: 'Write message here.....',
                                    hintStyle: TextStyle(
                                        color: Colors.white, fontSize: 15),
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
                          addMessage();
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
