import 'package:chat_app/add_room/add_room_navigator.dart';
import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/model/room.dart';
import 'package:flutter/material.dart';

class AddRoomViewModel extends ChangeNotifier {
  late AddRoomNavigator navigator;

  void addRoom(
      String roomTitle, String roomDescription, String categoryId) async {
    Room room = Room(
        roomDescription: roomDescription,
        roomTitle: roomTitle,
        roomId: '',
        categoryId: categoryId);
    try {
      navigator.showLoading();
      var creatRoom = await DatabaseUtils.addRoomToFirestore(room);
      navigator.hideLoading();
      navigator.showMwssage('Room Created');
      navigator.navigateToHome();
    } catch (e) {
      navigator.hideLoading();
      navigator.showMwssage(e.toString());
    }
  }
}
