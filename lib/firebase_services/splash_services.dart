import 'dart:async';
import 'package:authentication_firebase/ui/auth/posts/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../ui/auth/login_screen.dart';
import '../ui/firestore/firestore_list_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    // here we access the user info using firebase
    final user = auth.currentUser;

    // by these conditions we check that is user already logged in or not by checking the value of user we getting from firebase is having any currentUser info. or not
    if (user != null) {
      Timer(
        Duration(seconds: 3),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FireStoreScreen(),
          ),
        ),
      );
    } else {
      Timer(
        Duration(seconds: 3),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        ),
      );
    }
  }
}
