import 'dart:async';
import 'package:flutter/material.dart';
import '../ui/auth/login_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Timer.periodic(Duration(seconds: 3), (timer) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }
}
