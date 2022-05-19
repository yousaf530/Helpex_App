import 'package:flutter/cupertino.dart';
import 'package:helpex_app/models/user.dart';

class UserModel with ChangeNotifier {
  UserModel({required this.user});

  MyUser user;

  void setUser(MyUser user) {
    this.user = user;
    notifyListeners();
  }

}
