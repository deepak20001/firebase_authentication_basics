// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:authentication_firebase/ui/auth/posts/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../../widgets/round_button.dart';

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
  TextEditingController verificationCodeController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 80),
            TextFormField(
              controller: verificationCodeController,
              // keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "6 digit code"),
            ),
            SizedBox(height: 80),
            RoundButton(
              title: "Verify",
              loading: loading,
              onTap: () async {

                setState(() {
                  loading = true;
                });
                // accessing the verification id from the constructor
                final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: verificationCodeController.text.toString(),
                );

                try {
                  await auth.signInWithCredential(credential);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostScreen(),
                    ),
                  );
                } catch (e) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(e.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
