import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_share/Screens/Login/login_screen.dart';
import 'package:go_share/Screens/Signup/components/background.dart';
import 'package:go_share/Screens/Signup/components/or_divider.dart';
import 'package:go_share/Screens/Signup/components/social_icon.dart';
import 'package:go_share/components/already_have_an_account_acheck.dart';
import 'package:go_share/components/rounded_button.dart';
import 'package:go_share/components/rounded_input_field.dart';
import 'package:go_share/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Body extends StatelessWidget {
  String email;
  String password;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
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
            RoundedInputField(
              hintText: "Name",
              onChanged: (value) {

              },
            ),
            RoundedInputField(
              hintText: "Surname",
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "Email",
              onChanged: (value) {
                this.email = value;
              },
            ),
            RoundedInputField(
              hintText: "City",
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "Neighbourhood",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {
                this.password = value;
              },
            ),
            RoundedButton(
              color: Colors.green.shade400,
              text: "SIGNUP",
              press: ()  {
                firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);



              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/images/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/images/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/images/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
