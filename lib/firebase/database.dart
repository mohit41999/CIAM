import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addUserInfo(userData) async {
    FirebaseFirestore.instance
        .collection("users")
        .add(userData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> updateusername(String email, String newname) async {
    QuerySnapshot data = await getUserInfo(email);
    FirebaseFirestore.instance
        .collection("users")
        .doc(data.docs[0].id)
        .update({'userName': newname});
  }

  getUserInfo(String email) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection("users")
        .where('userName', isEqualTo: searchField)
        .get();
  }

  Future<bool?> addChatRoom(chatRoom, chatRoomId) async {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChats(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  getChatstoupdate(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .get();
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) async {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  // Future<void> updateChatroomId(String oldName, String newName) async {
  //   await getUserChats(oldName);
  //   FirebaseFirestore.instance
  //       .collection("chatRoom")
  //       .doc(data.docs[0].id)
  //       .update({
  //     'chatRoomId': data.docs[0].id.toString().replaceAll(oldName, newName)
  //   });
  // }
  getUserChatsforUpdate(String itIsMyName) async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .get();
  }

  updatechatroomId(String oldname, String newname) async {
    QuerySnapshot userInfoSnapshot =
        await DatabaseMethods().getUserChatsforUpdate(oldname);
    for (int i = 0; i < userInfoSnapshot.docs.length; i++) {
      var chatRoomId = userInfoSnapshot.docs[i]['chatRoomId'];
      var newchatRoomId = chatRoomId.toString().replaceAll(oldname, newname);
      print(newchatRoomId);
      List oldUsers = userInfoSnapshot.docs[i]['users'];

      print(oldUsers);
      for (int j = 0; j < oldUsers.length; j++) {
        if (oldUsers[j] == oldname) {
          oldUsers[j] = newname;
        }
      }
      QuerySnapshot chatsnapshot =
          await DatabaseMethods().getChatstoupdate(chatRoomId);

      print(oldUsers);
      await FirebaseFirestore.instance
          .collection("chatRoom")
          .doc(userInfoSnapshot.docs[i].id)
          .update({'chatRoomId': newchatRoomId, 'users': oldUsers});
    }
  }

  getUserChats(String itIsMyName) async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }
}
