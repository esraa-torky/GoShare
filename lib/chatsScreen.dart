import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
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
    return TextButton(
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
                  //ADD A PHOTO HERE!!
                  backgroundImage:
                  // userWhoReview[index]['image'] !=null ? FileImage(File(userWhoReview[index]['image']))
                  //     :userWhoReview[index]['image'].length != 0?NetworkImage(userWhoReview[index]['image'])
                  //     :
                  NetworkImage('https://icons-for-free.com/iconfiles/png/512/person-1324760545186718018.png'),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(//'user name'
                      allConections[index]['user_name'].toString()
                      ,style: TextStyle(color:Colors.green,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'QuickSand'),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'last massage'
                    ),
                  )
                ],)
              ],
            ),
          ),
          Divider(),


        ],
      ),),
    );
  }
  getChats() async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    await SharedPreferences.getInstance().then((value)
    {
      var id = value.getString('userID');
      users.doc(id).collection('chats').get().then((value)
      {
          value.docs.forEach((element) {
            allChats.add(element.id);
          });
          print(allChats);
      });});
}

}
