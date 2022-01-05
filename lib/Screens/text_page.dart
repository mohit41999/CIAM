import 'package:flutter/material.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';

class TextPage extends StatelessWidget {
  const TextPage({Key? key}) : super(key: key);

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
        title: commonAppBarTitleText(appbarText: 'Lorem Ipsum'),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //Expanded(child: ChatMessageList()),
              Container(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                              color: apptealColor,
                              //height: 30,
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: 'Write message here.....',
                                    hintStyle: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                    contentPadding: EdgeInsets.all(10),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none),
                                // controller: _controller,
                              ))),
                      Container(height: 48, width: 1.5),
                      GestureDetector(
                        child: Container(
                            height: 48,
                            width: 50,
                            color: apptealColor,
                            child: Icon(Icons.send, color: Colors.white)),
                        onTap: () {
                          //sendMessage();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
