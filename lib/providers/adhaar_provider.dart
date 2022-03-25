import 'package:change_app_package_name/change_app_package_name.dart';
import 'package:flutter/cupertino.dart';

class AdhaarProvider with ChangeNotifier {
  String adhaarNo = '';
  setAdhaarNo(String adh) {
    adhaarNo = adh;
    notifyListeners();
  }
}
