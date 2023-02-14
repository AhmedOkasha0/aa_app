import 'package:chat_app/add_room/add_room.dart';
import 'package:chat_app/add_room/room_widget.dart';
import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Image.asset(
          'assets/images/main_background.png',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              'Chat App ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddRoom.routeName);
            },
            child: Icon(Icons.add),
          ),
          body: StreamBuilder<QuerySnapshot<Room>>(
            stream: DatabaseUtils.getRooms(),
            builder: (context, asyncSnapShot) {
              if (asyncSnapShot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.blue,
                ));
              } else if (asyncSnapShot.hasError) {
                return Text(asyncSnapShot.error.toString());
              } else {
                // has data
                var roomList =
                    asyncSnapShot.data?.docs.map((doc) => doc.data()).toList()??[];
                return GridView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          child: RoomWidget(room: roomList[index]),
                        )
                      ],
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: roomList?.length ?? 0,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
