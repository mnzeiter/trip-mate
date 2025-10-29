import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  int? _userID;
  dynamic _tourID;

  int? get userID => _userID;

  set userID(int? value) {
    _userID = value;
    notifyListeners();
  }


  dynamic get tourID => _tourID;

  set tourID(dynamic value) {
    _tourID = value;
    notifyListeners();
  }
}
