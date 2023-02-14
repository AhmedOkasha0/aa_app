import 'package:chat_app/model/message.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  Message message;
  MessageWidget({required this.message});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return provider.user?.id == message.senderId
        ? SentMessage(message: message)
        : RecieveMessage(message: message);
  }
}

class SentMessage extends StatelessWidget {
  Message message;
  SentMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 24,horizontal: 12),
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              )),
          child: Text(
            message.content,
            style: TextStyle(color: Colors.white),
          ),
        ),
        Text(
          message.dateTime.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

class RecieveMessage extends StatelessWidget {
  Message message;
  RecieveMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          message.dateTime.toString(),
          style: TextStyle(color: Colors.black),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
          child: Text(
            message.content,
            style: TextStyle(color: Colors.black),
          ),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              )),
        ),
      ],
    );
  }
}
