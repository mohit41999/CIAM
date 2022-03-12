import 'package:flutter/material.dart';
import 'package:patient/Models/chatRooms.dart';
import 'package:patient/Screens/text_page.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API repo/api_constants.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  bool loading = true;
  late ChatRooms chatRooms;

  Future<ChatRooms> getchatrooms(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late Map<String, dynamic> response;
    await PostData(PARAM_URL: 'get_chat_doctor_list.php', params: {
      'token': Token,
      'user_id': prefs.getString('user_id'),
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
    return ChatRooms.fromJson(response);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getchatrooms(context).then((value) {
      setState(() {
        chatRooms = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (loading)
          ? Center(child: CircularProgressIndicator())
          : Messsages(context),
      appBar: AppBar(
        title: commonAppBarTitleText(appbarText: 'MyChats'),
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
    );
  }

  Widget Messsages(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: chatRooms.data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: (index == chatRooms.data.length + 1)
                          ? navbarht + 20
                          : 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Push(
                          context,
                          TextPage(
                            doctorid: chatRooms.data[index].userId,
                            doctorName: chatRooms.data[index].userName,
                          ),
                          withnav: false);
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              NetworkImage(chatRooms.data[index].profileImage)),
                      title: Text(
                        chatRooms.data[index].userName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      subtitle: Text(
                        chatRooms.data[index].message,
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: CircleAvatar(
                        radius: 4,
                        backgroundColor: apptealColor,
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
