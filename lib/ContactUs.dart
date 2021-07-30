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
          backgroundColor: Colors.green[300],
          email: 'goshare@gmail.com',
           textFont: 'QuickSand',
        ),

        backgroundColor: Colors.grey[100],
        body: ContactUs(
            cardColor: Colors.white,
            textColor: Colors.green[200],
            email: 'goshare@gmail.com',
            companyName: 'GoShare',
            companyFont: 'QuickSand',
            companyColor: Colors.green[300],
            phoneNumber: '000000000000',
            tagLine: 'DEVELOPERS',
            taglineColor: Colors.green[100],
            textFont: 'QuickSand',
            dividerColor: Colors.green[300],
      ),
    ));
  }

}