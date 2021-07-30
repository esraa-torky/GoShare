import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  String id;
  List allChats=[];
  List allConections=[];
  void initState()
  {
    getChats();
    super.initState();
  }
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor: Colors.grey[100],
      appBar: AppBar(
      title:Text('Chats',style: TextStyle(color: Colors.green[300],fontFamily: 'QuickSand',fontSize: 30,fontWeight: FontWeight.bold),),
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.grey[700]),
    ),
          body: SingleChildScrollView(child:listOfReviewsList()),
    );
  }
  Container listOfReviewsList(){
    return Container(
      color: Colors.white,

      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: allChats.length,
        itemBuilder: (BuildContext context,int index ){
          return GridTile(child: itemList(index));
        },
      ),
    );
  }
  itemList(int index){
    if(allChats[index]['uid']!=id){
    return TextButton(
      onPressed:
      (){Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return  Chat(allChats[index]);
            },
          ),
        );
      },
      child: Container(child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage:
                  allChats[index]['image'].length != 0?NetworkImage(allChats[index]['image'])
                      :
                  NetworkImage('https://icons-for-free.com/iconfiles/png/512/person-1324760545186718018.png'),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(//'user name'
                      allChats[index]['user_name'].toString()
                      ,style: TextStyle(color:Colors.green,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'QuickSand'),),
                  ),

                ],)
              ],
            ),
          ),
          Divider(),


        ],
      ),),
    );}
    else{
      return Container();
    }
  }
  getChats() async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    await SharedPreferences.getInstance().then((value)
    async {
      id = value.getString('userID');
      print(id);
      final snapsho = await FirebaseFirestore.instance.collection('Users').doc(id).collection('chats').get();
      var Chats=snapsho.docs.map((doc) => doc.data()).toList();
      print(Chats);
      for (int i=0;i<Chats.length;i++) {
        final snapshot = await FirebaseFirestore.instance.collection('Users').doc(Chats[i]['oId']).get();
        allChats.add(snapshot.data());

      }
      print(allChats);
    });
    setState(() {
    });


}

}
