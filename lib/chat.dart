import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Chat extends StatefulWidget {
  @override
  Map reciver;
  Chat(this.reciver);
  _ChatState createState() => _ChatState(this.reciver);
}

class _ChatState extends State<Chat> {
  String id1,id2;
  Map reciver;
  List massages=[];
  var chack;
  _ChatState(this.reciver);
  @override
  void initState()
  {
    getMassage();
    super.initState();
  }
  TextEditingController customeController=TextEditingController();
  Widget build(BuildContext context) {
    this.id2=reciver['uid'];

    return// reciverName != null?
    Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        shadowColor: Colors.transparent,
        leading: Icon(Icons.arrow_back),
        title: Row(
          children:<Widget> [
            CircleAvatar(backgroundColor: Colors.transparent,
              backgroundImage: reciver['image'] !=null ? FileImage(File(reciver['image']))
                  :reciver['image'].length != 0?NetworkImage(reciver['image'])
                  :NetworkImage('https://icons-for-free.com/iconfiles/png/512/person-1324760545186718018.png'),
              //NetworkImage('https://icons-for-free.com/iconfiles/png/512/person-1324760545186718018.png',
            ),

            SizedBox(width: 12),
            Text(reciver['user_name'],style: TextStyle(
                fontSize: 16
            ),
            ),
          ],
        ),
      ),
      body: chack!=null? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children:<Widget> [
            Expanded(child: ListView.builder(
                itemCount: massages.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context,index) =>messagebody(index)
            ),
            ),
            Row(
              children:<Widget> [
                Expanded(
                  child: TextFormField(
                    controller: customeController,
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          hintText: 'message',
                          //fillColor: Colors.grey[100],
                          //filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(width: 1,color: Colors.green),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(width: 2,color: Colors.green)
                        ),
                      ),

                      validator: (name){
                        if(name.isEmpty)
                        {
                        }
                        return null;
                      }
                  ),
                ),
                IconButton(icon: Icon(Icons.send,color: Colors.green,),
                  onPressed: (){
                  sendMassage(customeController.text);
                  customeController.clear();
                },
                )
              ],
            )
          ],
        ),
      ): Center(child: CircularProgressIndicator()),
    );
  }
  sendMassage(massage) async {

    DateTime now = DateTime.now();
    await SharedPreferences.getInstance().then((value) {
      id1 = value.getString('userID');
      FirebaseFirestore.instance.collection('Users').doc(id1)
          .collection('chats').doc(id2).collection('massage').add({
            'sender':id1,
            'massage':massage,
            'time':now.hour.toString() + ":" + now.minute.toString(),
      });
      FirebaseFirestore.instance.collection('Users').doc(id2)
          .collection('chats').doc(id1).collection('massage').add({
        'sender':id1,
        'massage':massage,
        'time':now.hour.toString() + ":" + now.minute.toString(),
      }
      );
      setState(() {
        getMassage();
      });
    });
  }
  getMassage() async {
    await SharedPreferences.getInstance().then((value) async {
      id1 = value.getString('userID');
      final snapshot= await FirebaseFirestore.instance.collection('Users').doc(id1).collection('chats').doc(id2).collection('massage').get();
      print(snapshot.docs);
      massages=snapshot.docs.map((doc) => doc.data()).toList();
      chack=true;
      setState(() {
      });});
  }

  Widget messagebody(index)=>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(massages[index]['massage']),
            ),
            decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(18.0,)
            )
        ),
      );
}
