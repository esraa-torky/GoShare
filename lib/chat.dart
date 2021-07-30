import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/rounded_input_field.dart';
class Chat extends StatefulWidget {
  @override
  Map reciver;
  Chat(this.reciver);
  _ChatState createState() => _ChatState(this.reciver);
}

class _ChatState extends State<Chat> {
  String id1,id2;
  int points1,points2;
  int point;
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

    return
    Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        shadowColor: Colors.transparent,
        leading: Icon(Icons.arrow_back),
        title: Row(
          children:<Widget> [
            CircleAvatar(backgroundColor: Colors.transparent,
              backgroundImage: reciver['image'].length != 0?NetworkImage(reciver['image'])
                  :NetworkImage('https://icons-for-free.com/iconfiles/png/512/person-1324760545186718018.png'),

            ),

            SizedBox(width: 12),
            Text(reciver['user_name'],style: TextStyle(
                fontSize: 16
            ),
            ),
          Align(
              alignment: Alignment.centerRight,
              child: IconButton(icon:Icon(Icons.check_box_sharp), onPressed: () {


                showDialog(context: context, builder:(context) {
                  return transferPoints(context);
                });
              }
              ))
          ],
        ),
      ),
      body: chack!=null? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children:<Widget> [
            Expanded(child: ListView.builder(
                reverse: false,
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
                          hintText: 'write your message here',
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
      FirebaseFirestore.instance.collection('Users').doc(id1).collection('chats').doc(id2).collection('massage').add({
            'sender':id1,
            'massage':massage,
            'time':now.hour.toString() + ":" + now.minute.toString()+":"+now.second.toString(),});
      FirebaseFirestore.instance.collection('Users').doc(id1).collection('chats').doc(id2).set({"oId":id2,});
      FirebaseFirestore.instance.collection('Users').doc(id2)
          .collection('chats').doc(id1).collection('massage').add({
        'sender':id1,
        'massage':massage,
        'time':now.hour.toString() + ":" + now.minute.toString()+':'+now.second.toString(),
      }
      );
      FirebaseFirestore.instance.collection('Users').doc(id2)
          .collection('chats').doc(id1).set({
        'oId':id1,
      });
      setState(() {
        getMassage();
      });
    });
  }
  getMassage() async {
    await SharedPreferences.getInstance().then((value) async {
      id1 = value.getString('userID');
      final snapshot= await FirebaseFirestore.instance.collection('Users').doc(id1).collection('chats').doc(id2).collection('massage').get();
      massages=snapshot.docs.map((doc) => doc.data()).toList();
      chack=true;
      setState(() {
        massages.sort((l1,l2){
          var r = l1["time"].compareTo(l2["time"]);
          if (r != 0) return r;
          return l1["time"].compareTo(l2["time"]);
        });
      });});
  }

  Widget messagebody(index){
    if (massages[index]['sender']==id1){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Container(
            width: MediaQuery.of(context).size.width*0.65,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(massages[index]['massage']),
                        )),
                    Align(alignment: Alignment.bottomRight,
                        child: Text(massages[index]['time'])),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(18.0,)
              )
          ),
        ),
      );}
  else{
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:  Column(
                  children: [
                    Align(alignment: Alignment.topRight,
                        child: Text(massages[index]['massage'])),
                    Align(alignment: Alignment.bottomLeft,
                        child: Text(massages[index]['time'])),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(18.0,)
              )
          ),
        ),
      );
    }
  }
error(context){
  return SimpleDialog(
    title: Text('Error',style: TextStyle(color: Colors.green[400]),),
    children: [
    SimpleDialogItem(
    text: 'Points',
    size: 40,
    child: Text('You Don\'t Have Enough points'),
  ),
  MaterialButton(elevation: 5.0,
  child: Text('Okay',style: TextStyle(color: Colors.green[400]),),
  onPressed: (){
    Navigator.of(context).pop();
  })]);
}
transferPoints(context){
  return SimpleDialog(
    title: Text('Transfer Points',style: TextStyle(color: Colors.green[400]),),
    children: [
      SimpleDialogItem(
        text: 'Points',
        size: 40,
        child: TextField(
          onChanged: (value) {
            point=int.parse( value);
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText:'0',),
        ),
      ),
      MaterialButton(elevation: 5.0,
          child: Text('Transfer',style: TextStyle(color: Colors.green[400]),),
          onPressed: () async {
            Map sender,r;
            await FirebaseFirestore.instance.collection('Users').doc(reciver['uid']).get().then((value)

            {  r=value.data();
              points2 =r['points'];
            });

             await FirebaseFirestore.instance.collection('Users').doc(id1).get().then((value) async {
            sender= value.data();
            points1=sender['points'];
            if(points1>point){
            points1-=point;
            points2+=point;
            await FirebaseFirestore.instance.collection('Users').doc(id1).update(
            {
            'points':points1,
            }
            );
            await FirebaseFirestore.instance.collection('Users').doc(id2).update(
            {
            'points':points2,
            }
            );
            }
            else{
              showDialog(context: context, builder:(context) {
                return error(context);

              });
              setState(() {});
                  Navigator.of(context).pop();
            }
            });
            setState(() {});
            Navigator.of(context).pop();}
          )
    ],
  );
}
}
class SimpleDialogItem extends StatelessWidget {
  const SimpleDialogItem(
      {Key key, this.icon, this.color, this.text, this.onPressed, this.child, this.size})
      : super(key: key);
  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;
  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Column(
          children: [Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text,
                  style: TextStyle(color: Colors.green[400],
                      fontSize: 18,
                      fontWeight: FontWeight.bold),),
              ),

            ],
          ),
            Container(
              height: size,
              child: child,
            ),
          ]
      ),
    );
  }
}