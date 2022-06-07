import 'package:flutter/material.dart';
import 'package:mynda/model/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel user = UserModel(role: 'Guest');
  UserModel temp = UserModel(role: 'Guest');

  set setTemp(UserModel user) {
    temp = user;
    notifyListeners();
  }

  set setTempRegion(String region) {
    temp.region = region;
    notifyListeners();
  }

  set setTempState(String state) {
    temp.states = state;
    notifyListeners();
  }

  set setUpdate(UserModel user) {
    this.user = user;
    notifyListeners();
  }

  void login({required UserModel user}) {
    this.user = user;
    notifyListeners();
  }

  void logout() {
    user = UserModel(role: 'Guest');
    notifyListeners();
  }
}
