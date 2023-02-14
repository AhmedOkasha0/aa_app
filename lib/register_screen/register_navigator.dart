import 'package:chat_app/model/my_user.dart';

abstract class RegisterNavigator {
  /// common method between view and viewmodel
  void showLoding() {}
  void hideLoading() {}
  void showMessage(String message) {}
  void navigateToHome(MyUser user);
}
