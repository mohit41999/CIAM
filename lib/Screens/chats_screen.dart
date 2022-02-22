import 'package:flutter/material.dart';
import 'package:patient/Screens/text_page.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Messsages(context),
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
}

Widget Messsages(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TextPage(
                                doctorid: '',
                                doctorName: '',
                              )));
                },
                child: ListTile(
                  leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey,
                      backgroundImage: AssetImage('')),
                  title: Text(
                    'Lorem ipsum',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  subtitle: Text(
                    'Lorem ipsum dolor sit amet, consetetur.',
                    style: TextStyle(fontSize: 12),
                  ),
                  trailing: CircleAvatar(
                    radius: 4,
                    backgroundColor: apptealColor,
                  ),
                ),
              );
            }),
      ],
    ),
  );
}
