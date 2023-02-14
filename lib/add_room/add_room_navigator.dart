import 'package:chat_app/model/my_user.dart';

abstract class AddRoomNavigator{
  void showLoading();
  void hideLoading();
  void showMwssage(String message);
  void navigateToHome( );
}