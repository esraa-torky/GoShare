import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_share/Home_page.dart';
import 'package:go_share/category_item.dart';
import 'package:go_share/chat.dart';
import 'package:go_share/item.dart';
import 'package:go_share/sellerProfile.dart';
import 'package:go_share/setting.dart';

import 'Screens/Welcome/welcome_screen.dart';
import 'UserProfile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List categories=['ELECTRONICS','CLOTHES','HOME AND GARDENING','FILM','SPORTS'];
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.grey[100],
        drawer: Drawer(

          child: Container(
            color: Colors.grey[100],
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                  ),
                  child: Center(child: Text('Go Share',

                    style: TextStyle(color: Colors.grey[200],fontFamily: 'QuickSand',fontSize: 30,fontWeight: FontWeight.bold),))),
                  // CircleAvatar(
                  //   radius: 20,
                  //     backgroundImage: AssetImage('assets/images/GoShare.png')),),

                ListTile(
                  title: Text('User Profile', style: TextStyle(color: Colors.grey[600],fontFamily: 'QuickSand',fontWeight: FontWeight.w600)),
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return UserProfile();
                        },
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text('Chat',style: TextStyle(color: Colors.grey[600],fontFamily: 'QuickSand',fontWeight: FontWeight.w600)),
                  onTap: () {

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return Chat();
                    //     },
                    //   ),
                    // );
                  },
                ),

                ListTile(
                    title: Text('Maps',style: TextStyle(color: Colors.grey[600],fontFamily: 'QuickSand',fontWeight: FontWeight.w600)),
                    onTap: () {

                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return SellerProfile();},),);}),
                ListTile(
                  title: Text('Settings',style: TextStyle(color: Colors.grey[600],fontFamily: 'QuickSand',fontWeight: FontWeight.w600)),
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return EditProfilePage();
                        },
                      ),
                    );
                  },
                ),
                ListTile(

                  title: Text('Contact Us',style: TextStyle(color: Colors.grey[600],fontFamily: 'QuickSand',fontWeight: FontWeight.w600)),
                  onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SellerProfile();},),);}),

                Container(
                  color: Colors.red[50],
                  child: ListTile(
                    title: Text('Log Out',style: TextStyle(color: Colors.redAccent,fontFamily: 'QuickSand',fontWeight: FontWeight.w600),),
                    onTap: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> WelcomeScreen()));});

                    },
                  ),
                ),
              ],
            ),
          ),

        ),
        appBar: AppBar(
          title:Text('Go Share',style: TextStyle(color: Colors.green[300],fontFamily: 'QuickSand',fontSize: 30,fontWeight: FontWeight.bold),),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.grey[700])

        ),

        body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget> [
                SizedBox(height: 12,),
                new GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: categories.length,
                    scrollDirection: Axis.vertical,
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10,mainAxisSpacing: 12,),
                    itemBuilder: (BuildContext context, int index) => itemcard(index)
                )
              ],
            ),
          ),
        )
      );

  }
  Widget itemcard(index)=>Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18.0),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.green,
          blurRadius: 2.0,
          spreadRadius: 0.0,
          offset: Offset(2.0, 2.0), // shadow direction: bottom right
        )
      ],
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: TextButton(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children:<Widget> [
          Expanded(child: Image.network('https://www.narscosmetics.eu/dw/image/v2/BCMQ_PRD/on/demandware.static/-/Sites-itemmaster_NARS/default/dw773e6329/hi-res/NARS_FA19_Lipstick_Soldier_LPS_Raw_Seduction_Satin_GLBL_B_square.jpg?sw=856&sh=750&sm=fit',fit: BoxFit.fitWidth,)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(categories[index],style: TextStyle(color: Colors.green[300],
                fontWeight: FontWeight.bold,fontSize: 14
            ),
            ),
          ),
        ],
      ),
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CategoryItem(name: categories[index],);
            },
          ),
        );

      },
    ),
  );
}
