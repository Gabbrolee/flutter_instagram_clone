import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/resources/auth_method.dart';

import '../model/user.dart';

class UsersProvider with ChangeNotifier{
 User? _user;
 final AuthMethod _authMethod = AuthMethod();

 User get getUser => _user!;

 Future<void> refreshUser() async{
  User user = await _authMethod.getUserDetails();
  _user = user;
  notifyListeners();
 }
}