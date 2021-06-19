import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_share/Home_page.dart';
import 'package:go_share/Screens/Login/components/background.dart';
import 'package:go_share/Screens/Signup/signup_screen.dart';
import 'package:go_share/Screens/Welcome/welcome_screen.dart';
import 'package:go_share/components/already_have_an_account_acheck.dart';
import 'package:go_share/components/rounded_button.dart';
import 'package:go_share/components/rounded_input_field.dart';
import 'package:go_share/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';




class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email ;
  String password ;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 100.0,
              backgroundImage: AssetImage('assets/images/GoShare.png'),
            ),
            SizedBox(height: size.height * 0.05),

        RoundedInputField(
          hintText: "Your Email",
          onChanged: (value) {
            email=value;
          },
        )
        ,
        RoundedPasswordField(
          onChanged: (value) {
            password=value;
          },),
            RoundedButton(
              color: Colors.green.shade400,
              text: "LOGIN",
              press: () async {
                var email = this.email;
                try {
                   await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password

                  ).then((value) async {
                     SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setString('userID', value.user.uid);
                   });
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found' || e.code == 'wrong-password') {
                    WrongPasswordOrEmailMessage(context).then((onValue) {});
                  }
                  else if(email == null || password == null){
                    ErrorMessage(context).then((onValue) {});
                  }

                  else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return HomePage();
                        },
                      ),
                    );

                  }
                }

              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ErrorMessage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text(
                      'Please do not forget to enter email or password'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  WrongPasswordOrEmailMessage(BuildContext context){
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text(
                      'Wrong email or password!'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });

  }
}




