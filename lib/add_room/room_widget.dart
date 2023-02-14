import 'package:chat_app/chat/chat_screen.dart';
import 'package:chat_app/model/room.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
Room room;
RoomWidget({required this.room});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(ChatScreen.routName,arguments: room);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],

      ),
        child: Column(
          children: [
            Image.asset('assets/images/${room.categoryId}.png',height: 150,width: 150,fit: BoxFit.fill,),
            SizedBox(height: 10,),
            Text(room.roomTitle),
          ],
        ),

      ),
    );
  }
}
