import 'package:flutter/material.dart';
import 'package:map_proj/model/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel user = UserModel(role: 'Guest');
  // UserModel user = UserModel(role: 'Member');

  void login({required UserModel user}) {
    this.user = user;
    notifyListeners();
  }

  void logout() {
    user = UserModel(role: 'Guest');
    notifyListeners();
  }
}