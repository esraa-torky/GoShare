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
import 'package:go_share/views/home/home_view.dart';

class Body extends StatelessWidget {
  @override
  bool isName = false;
  bool isSurname = false;
  bool isPassword = false;
  bool isEmail = false;

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
                if (!value.isEmpty) {
                  isName = true;
                }
              },
            ),
            RoundedInputField(
              hintText: "Surname",
              onChanged: (value) {
                if (!value.isEmpty) {
                  isSurname = true;
                }
              },
            ),
            RoundedInputField(
              hintText: "Email",
              onChanged: (value) {
                if (!value.isEmpty) {
                  isEmail = true;
                }
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
                if (!value.isEmpty) {
                  isPassword = true;
                }
              },
            ),
            RoundedButton(
              color: Colors.green.shade400,
              text: "SIGNUP",
              press: () {
                if ((isName && isSurname && isEmail && isPassword) == false) {
                  ErrorMessage(context).then((onValue) {});
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomeView();
                      },
                    ),
                  );
                }
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
                      'Please do not forget to enter user name, surname, email or password'),
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