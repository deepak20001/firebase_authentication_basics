import 'package:authentication_firebase/ui/auth/login_with_phone_number.dart';
import 'package:authentication_firebase/ui/forgot_password.dart';

import '../auth/posts/post_screen.dart';
import '../auth/signup_screen.dart';
import 'package:authentication_firebase/utils/utils.dart';
import 'package:authentication_firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // loading var declared here
  bool loading = false;
  // added a form key to manage textform fields should not remain empty
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
  }

  // added check login function
  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
      email: emailController.text.toString(),
      password: passwordController.text.toString(),
    )
        .then((value) {
      // here we can get the value on screen we want using Utils class if the above fn runs successfully
      Utils().toastMessage(value.user!.email.toString());
      // now moving to post screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PostScreen(),
        ),
      );
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      // direct print statement makes app slow so use debugPrint
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // add willPopScope widget when click to lowe android back button it will exit
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Login"),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),

                      // validating the field shouldn't stay empty
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter e-mail";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock_open),
                      ),

                      // validating the field shouldn't stay empty
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter password";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              RoundButton(
                title: "Login",
                loading: loading,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // login function created here
                    login();
                  }
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: Text("Forgot password?"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        ),
                      );
                    },
                    child: Text("Sign up"),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginWithPhoneNumber(),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Center(
                    child: Text("Login with phone"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
