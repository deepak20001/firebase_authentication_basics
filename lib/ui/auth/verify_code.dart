// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class VerifyCodeScreen extends StatefulWidget {
  // this id we will get from the LoginWithPhoneNumber screen
  final String verificationId;
  const VerifyCodeScreen({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
