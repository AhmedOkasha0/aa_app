import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/firebase_error.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/register_screen/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RegisterViewModel extends ChangeNotifier {
  late RegisterNavigator navigator;
  void RegisterFirebaseAuth(String email, String password, String lastName,
      String firstName, String userName) async {
    navigator.showLoding();
    try {
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('firebase user id :${result.user?.uid}');

      var user = MyUser(
          email: email,
          id: result.user?.uid ?? '',
          userName: userName,
          lastName: lastName,
          firstName: firstName);
      
      print('id:$result.user?.uid');

      var dataUser = await DatabaseUtils.registerUser(user);
      navigator.hideLoading();
      navigator.showMessage('Register successfully');
      navigator.navigateToHome(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseError.weakPassword) {
        navigator.hideLoading();
        navigator.showMessage('The password provided is too weak');
        print('The password provided is too weak.');
      } else if (e.code == FirebaseError.emaliAlreadyInUse) {
        navigator.hideLoading();
        navigator.showMessage('The account already exists for that email');
        print('The account already exists for that email.');
      }
    } catch (e) {
      navigator.hideLoading();
      navigator.showMessage('Something was wrong');
      print(e);
    }
  }
}
