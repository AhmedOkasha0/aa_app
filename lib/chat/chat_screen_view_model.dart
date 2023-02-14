import 'package:chat_app/chat/chat_screen_navigator.dart';
import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class ChatScreenViewModel extends ChangeNotifier {
  late ChatScreenNavigator navigator;
  late MyUser currentUser;
  late Room room;
  late Stream<QuerySnapshot<Message>> streamMessage;

  void sendMessage(String content) async {
    Message message = Message(
      roomId: room.roomId,
      content: content,
      dateTime: DateTime.now().millisecondsSinceEpoch,
      senderId: currentUser.id,
      senderName: currentUser.userName,
    );
    try {
      var res = await DatabaseUtils.insertMessage(message);
      navigator.clearMessage();

    } catch (e) {
      navigator.showMessage(e.toString());
    }
  }

  void listenForUpdateMessage() {
    streamMessage = DatabaseUtils.getMessageFromFireStore(room.roomId);
  }
}
