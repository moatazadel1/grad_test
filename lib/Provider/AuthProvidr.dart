import 'package:new_app/Database/Model/user.dart' as MyUser;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Database/UserDao.dart';

class AuthProvidr extends ChangeNotifier {
  User? firebaseAuthUser;

  MyUser.User? databaseUser;

  Future<void> register(String Email, String Password) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: Email, password: Password);
    await UserDao.createUser(
        MyUser.User(id: credential.user?.uid, email: Email));
  }

  Future<void> login(String Email, String Password) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: Email, password: Password);
    var user = await UserDao.getUser(credential.user!.uid);
    print("Sign-in successful!");
    databaseUser = user;
    firebaseAuthUser = credential.user;

    print("Email: $Email");
    print("Password: $Password");
    // Handle successful sign-in
  }
}
