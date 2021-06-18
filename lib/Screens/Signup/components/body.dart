import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_share/Home_page.dart';
import 'package:go_share/Screens/Login/login_screen.dart';
import 'package:go_share/Screens/Signup/components/background.dart';
import 'package:go_share/Screens/Signup/components/or_divider.dart';
import 'package:go_share/Screens/Signup/components/social_icon.dart';
import 'package:go_share/UserProfile.dart';
import 'package:go_share/components/already_have_an_account_acheck.dart';
import 'package:go_share/components/rounded_button.dart';
import 'package:go_share/components/rounded_input_field.dart';
import 'package:go_share/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:toast/toast.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email;
  String password;
  String image,neighbourhood,name,surname,city;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.green),
            ),
            RoundedInputField(
              hintText: "Name*",
              onChanged: (value) {
                name=value;
              },
            ),
            RoundedInputField(
              hintText: "Surname*",
              onChanged: (value) {
                surname=value;
              },
            ),
            RoundedInputField(
              icon: Icons.email_rounded,
              hintText: "Email*",
              onChanged: (value) {
                this.email = value;
              },
            ),
            RoundedInputField(
              hintText: "City",
              onChanged: (value) {
                city=value;
              },
            ),
            RoundedInputField(
              hintText: "Neighbourhood",
              onChanged: (value) {
                neighbourhood=value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                this.password = value;
              },
            ),
            RoundedButton(
              color: Colors.green.shade400,
              text: "SIGNUP",
              press: () {
                FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
                    .then((value) async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setString('userID', value.user.uid);
                  setState(() {
                    addUsers(email, password,name,surname,neighbourhood,city,value.user.uid);
                  });
                }).catchError((e) {
                  Toast.show(e.toString(), context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                });
              },
            ),
            SizedBox(height: 20),
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

  void addUsers(String email, String password, String name,String surname,String neighbourhood,String city,String uid) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    users..doc(uid).set(
        {
          'user_name':name+" "+surname,
          'email':email,
          'city':city,
          'neighbourhood':neighbourhood,
          'uid':uid,
          'image':'',
          'points': 100,
        }).then((value)
    {
      Navigator.push(context, MaterialPageRoute(builder: (ctx)=>HomePage()));

    }).catchError((e)
    {
      Toast.show(e.toString(), context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    });
  }
  }

