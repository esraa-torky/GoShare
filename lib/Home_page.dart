import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_share/Home_page.dart';
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
                  title: Text('User Profile'),
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
                  title: Text('Chat'),
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Chat();
                        },
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text('Settings'),
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SettingsUI();
                        },
                      ),
                    );
                  },
                ),
                ListTile(
                    title: Text('Maps'),
                    onTap: () {

                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return SellerProfile();},),);}),
                ListTile(

                  title: Text('Contact Us'),
                  onTap: () {

                    Navigator.pop(context);
                  },
                ),
                Container(
                  color: Colors.red[50],
                  child: ListTile(
                    title: Text('Log Out',style: TextStyle(color: Colors.redAccent),),
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
                /*Text('Category name',style: TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 20
                ),
                ),*/
                SizedBox(height: 12,),
                new GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: 5,
                    scrollDirection: Axis.vertical,
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10,mainAxisSpacing: 12,),
                    itemBuilder: (BuildContext context, int index) => itemcard()
                )
              ],
            ),
          ),
        )
      );

  }
  List images=['https://www.notebookcheck-tr.com/uploads/tx_nbc2/MicrosoftSurfaceLaptop3-15__1_.JPG','https://i.pinimg.com/564x/9c/ec/cd/9ceccd67b51eec22ebe7079e0063eed9.jpg'];
  Widget itemcard()=>Container(
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget> [
                Text('Category name',style: TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 14
                ),
                ),
                Text('20 Points',style: TextStyle(
                    color: Colors.grey,fontSize: 12
                ),
                ),
              ],
            ),
          ),
        ],
      ),
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
          ),
        );
      },
    ),
  );
}
