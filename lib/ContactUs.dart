import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';

class ContactUsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: ContactUsBottomAppBar(
          companyName: 'GOSHARE',
          textColor: Colors.white,
          backgroundColor: Colors.teal.shade300,
          email: 'goshare@gmail.com',
          // textFont: 'Sail',
        ),

        backgroundColor: Colors.teal,
        body: ContactUs(
            cardColor: Colors.white,
            textColor: Colors.teal.shade900,
            email: 'goshare@gmail.com',
            companyName: 'GoShare',
            companyColor: Colors.teal.shade100,
            phoneNumber: '000000000',
            tagLine: 'DEVELOPERS',
            taglineColor: Colors.teal.shade100,


      ),
    ));
  }

}