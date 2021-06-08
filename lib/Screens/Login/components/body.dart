import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_share/Screens/Login/components/background.dart';
import 'package:go_share/Screens/Signup/signup_screen.dart';
import 'package:go_share/Screens/Welcome/welcome_screen.dart';
import 'package:go_share/components/already_have_an_account_acheck.dart';
import 'package:go_share/components/rounded_button.dart';
import 'package:go_share/components/rounded_input_field.dart';
import 'package:go_share/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_share/views/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Body extends StatelessWidget {
  final email = RoundedInputField(
    hintText: "Your Email",
    onChanged: (value) {

    },
  );

  final password = RoundedPasswordField(
    onChanged: (value) {},
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
              child: ListTile(
                tileColor: Colors.amber,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
              child: ListTile(
                tileColor: Colors.green,
              ),
            ),
            email,
            password,
            RoundedButton(
              color: Colors.green.shade400,
              text: "LOGIN",
              press: () {
                var email = this.email;
                //FirebaseAuth.instance.em
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomeView();
                    },
                  ),
                );
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
/*
  Future<http.Response> createAlbum(String title) {
    return http.post(
      Uri.parse('http://localhost:4567/passwordChecker'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );
  }
  */
}
