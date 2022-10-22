import 'package:authentication_firebase/widgets/round_button.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 80),
            TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(hintText: "+1 234 567 890"),
            ),
            SizedBox(height: 80),
            RoundButton(
              title: "Login",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
