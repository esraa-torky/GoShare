import 'dart:developer';
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
  Widget build(BuildContext context) {
    var test=0;
    return Center(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: colors[0],
          title: Text('User Profile'),
        ),
        body: Column(
            children: <Widget>[userPhoto(), Text('itemlist will be here!!'),
          ]),
      ),
    );
  }
//display the profile photo and user name
  Container userPhoto() {
    return Container(
      color: Colors.blueGrey[50],
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Opacity(
                  opacity: 0.4,
                  //opening change photo/show photo menu
                  child: Center(
                    child: FocusedMenuHolder(
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
                      child: CircleAvatar(
                        radius: 40,
                        //ADD A PHOTO HERE!!
                        backgroundImage: AssetImage('images/user.png'),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                //ADD ICON AND MAKE IT APPLE TO CHANGE
                child: Text(
                  'User Name',
                  style: TextStyle(color: colors[2], fontSize: 20),
                ),
              ),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Email@gmail.com',
              ),
            ))
          ]),
    );
  }


}
//creating the app colors
List creatingColors() {
  var colors = [];
  colors.add(Color(0xff669966));
  colors.add(Color(0xffffcc00));
  colors.add(Color(0xff333333));
  return colors;
}
