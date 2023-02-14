import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/firebase_error.dart';
import 'package:chat_app/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  late LoginNavigator navigator;
  void loginFirebaseAuth(String email, String password) async {
    try {
      navigator.showLoding();
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      var userobj = await DatabaseUtils.getUser(result.user?.uid ?? '');
      if (userobj == null) {
        navigator.hideLoading();
        navigator.showMessage('Sometging went wrong');
      } else {
        navigator.navigateToHome(userobj);
      }
      navigator.hideLoading();
      navigator.showMessage('Login successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseError.userNotFound) {
        navigator.hideLoading();
        navigator.showMessage('No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == FirebaseError.wrongPassword) {
        navigator.hideLoading();
        navigator.showMessage('Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
    }
  }
}
