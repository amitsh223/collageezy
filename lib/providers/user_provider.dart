
import 'package:collageezy/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  UserInformation userInfo = UserInformation();

  setUser(UserInformation user) {
    userInfo = user;
    notifyListeners();
  }
}
