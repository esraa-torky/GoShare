import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';

var colors = creatingColors();

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  String name='user name';
  String emailAdd='Email@gmail.com';
  TextEditingController customeController=TextEditingController();
  Widget build(BuildContext context) {
    var test=0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colors[0],
        title: Text('User Profile'),
      ),
      body: Stack(
          fit: StackFit.loose,
          children:<Widget>[ Column(
            children: [
              userPhoto(),
              listOfItems(),
            ],
          ),
            addButton(),
        ]),


    );
  }
  Container addButton(){
    return Container(
      alignment: Alignment.centerRight,
      child: CircleAvatar(
        backgroundColor: colors[0],
        child: IconButton(icon:Icon(Icons.add,color: colors[1],),
        onPressed: (){},),),
    );
  }
//display the profile photo and user name
  Container userPhoto() {
    return Container(
      height:MediaQuery.of(context).size.width*0.35 ,
      color: Colors.blueGrey[50],
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Opacity(
                opacity: 0.4,
                //opening change photo/show photo menu
                child: profilePicOptions(),
              ),
            ),
            Column ( children:<Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Row( mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(name,
                        style: TextStyle(color: colors[2], fontSize: 20),
                      ),
                      IconButton(icon:Icon( Icons.create_rounded,color: colors[2],
                          size: 18)
                        , onPressed: ()
                        {changeUserName(context).then((onValue){
                          name=onValue;
                        });
                        },)
                    ],
                  ),
                ),
              ),

            Center(
                child: Row(
                  children: [
                    Text(emailAdd,
                      style: TextStyle(fontSize: 18,color: colors[2]),
                    ),
                  ],
                ))
          ])]),
    );
  }
  FocusedMenuHolder profilePicOptions(){
    return FocusedMenuHolder(
      menuWidth:  MediaQuery.of(context).size.width*0.5,
      openWithTap: true,
      //NOT DONE YET !!!!
      menuItems: [
        FocusedMenuItem(title: Text('View profile picture'),
          trailingIcon: Icon(Icons.face,color: colors[2],),
        ),
        FocusedMenuItem(title: Text('Change profile picture'),
          trailingIcon: Icon(Icons.image,color: colors[2],),
        ),
      ],
      onPressed: (){},
      blurBackgroundColor: colors[2],
      child: profilePic(),
    );
  }
  // profile pic as an icon
  CircleAvatar profilePic(){
    return CircleAvatar(
      radius: 40,
      //ADD A PHOTO HERE!!
      child: Icon(Icons.account_circle,color: colors[2],size: 80,),
      //backgroundImage: AssetImage('images/user.png'),
      backgroundColor: Colors.transparent,
    );
  }

  changeUserName(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(title: Text('new user name',
        style: TextStyle(color: colors[0]),),
        content: TextField(controller: customeController,),
        actions: [MaterialButton(elevation: 5.0,
            child: Text('Submit',style: TextStyle(color: colors[0]),),
            onPressed: (){
          Navigator.of(context).pop(customeController.text.toString());
            })],
      );
    },);
  }
}
Container listOfItems(){
  return Container(

  );
}
//creating the app colors
List creatingColors() {
  var colors = [];
  colors.add(Color(0xff669966));
  colors.add(Color(0xffffcc00));
  colors.add(Color(0xff333333));
  return colors;
}
