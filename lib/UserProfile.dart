import 'dart:developer';

import 'package:flutter/material.dart';
var colors=creatingColors();
class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {


  @override
  Widget build(BuildContext context) {

    return Center(child: Scaffold(backgroundColor:Colors.white,
      appBar: AppBar(backgroundColor: colors[0],title: Text('User Profile'),),
      body: Column( children:<Widget> [userPhoto(),Text('itemlist will be here!!')]
    ),
    ),);
  }
  Container userPhoto(){
    return Container(
      color: Colors.blueGrey[50],
      child: Column(mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget> [

        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
            radius: 50,
            backgroundColor: colors[1],
      ),
          ),),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('User Name',style: TextStyle(color: colors[2],fontSize: 20),),
          ),
        )]),
    );
  }

}
List creatingColors(){
  var colors=[];
  colors.add(Color(0xff669966));
  colors.add(Color(0xffffcc00));
  colors.add(Color(0xff333333));
  return colors;
}