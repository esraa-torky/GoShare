import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_share/UserProfile.dart';
import 'package:go_share/category_item.dart';
import 'package:go_share/chat.dart';
import 'package:go_share/sellerProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Item extends StatefulWidget {
  @override
  Map item;
  Item({this.item});
  _ItemState createState() => _ItemState(itemDataMap: item);
}

class _ItemState extends State<Item> {
  Map itemDataMap,seller;
  String id;
  _ItemState({this.itemDataMap,});
  void initState()
  {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CategoryItem();
              },
            ),
          );
        }, icon: Icon(Icons.arrow_back,color: Colors.black,),),
      )
      ,body: seller != null?
    SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.all(25.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget> [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.green)
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: double.infinity,
               height: 300,
               child: Image.network(itemDataMap['image'], fit: BoxFit.fitHeight),

              ),
              SizedBox(height: 15),
              Text(itemDataMap['name']
                ,style: TextStyle(
                  color: Colors.grey,fontSize: 14
              ),
              ),
              SizedBox(height: 10),
              Text(itemDataMap['points'].toString()+' P'
                ,
                style: TextStyle(
                  color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18
              ),
              ),
              SizedBox(height: 15,),
              Divider(
                height: 5,
                thickness: 2,
                color: Colors.grey[200],
              ),
              SizedBox(height: 10),
              Text('About this item',style: TextStyle(
                  color: Colors.black,fontSize: 16
              ),
              ),
              SizedBox(height: 8),
              Text(itemDataMap['description'],
                style: TextStyle(
                  color: Colors.grey[500],fontSize: 14
                ), textDirection: TextDirection.ltr
              ),
              SizedBox(height: 20),
              Divider(
                height: 5,
                thickness: 2,
                color: Colors.grey[200],
              ),
              SizedBox(height: 10),
              Text('seller',style: TextStyle(
                  color: Colors.black,fontSize: 16
              ),
              ),
              SizedBox(height: 10),
              Row(
                children:<Widget> [
                  Container(
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      border: new Border.all(
                        color: Colors.green,
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: TextButton(
                      onPressed: (){
                        if (seller['uid']!=id){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SellerProfile(seller: seller,);
                            },
                          ),
                        );}
                        else{
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return UserProfile();
                              },
                            ),
                          );
                        }
                      },
                      child: CircleAvatar(backgroundImage:

                          seller['image'].length != 0?NetworkImage(seller['image'])
                          :NetworkImage('https://icons-for-free.com/iconfiles/png/512/person-1324760545186718018.png'
                     , )

                      ,backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget> [
                    Text(seller['user_name'].toString(),style: TextStyle(
                        color: Colors.black,fontSize: 14
                    ),
                    ),
                     RatingBar.builder(
                       initialRating: seller['rating'].toDouble(),
                       minRating: 1,
                       itemSize: 15,
                       direction: Axis.horizontal,
                       allowHalfRating: true,
                       itemCount: 5,
                       itemBuilder: (context, _) => Icon(
                         Icons.star,
                         color: Colors.amber,
                       ),
                    ),
                  ],)
                ],
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child:
                  seller['uid']!=id?
                  RaisedButton.icon(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Chat(seller);
                          },
                        ),
                      );
                    },
                    disabledColor: Colors.green,
                      icon:Icon(Icons.chat,color: Colors.white,),
                      label: Text("Contact Me",style: TextStyle(
                          color: Colors.white, fontSize: 16.0))
                  ): RaisedButton.icon(
                    onPressed: () async {
              Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) {
              return UserProfile();
              },
              ),
              );
              },
                  disabledColor: Colors.green,
                  icon:Icon(Icons.chat,color: Colors.white,),
                  label: Text("Go To Your Profile",style: TextStyle(
                      color: Colors.white, fontSize: 16.0))
              ),
                ),
              ),
            ],
           ),
         ),
      ): Center(child: CircularProgressIndicator())
    );

  }
  getData() async
  {
    CollectionReference user = FirebaseFirestore.instance.collection('Users');

    await SharedPreferences.getInstance().then((value)
    {
      id = value.getString('userID');

        });
      user.doc(itemDataMap['sellerId']).get().then((value)
      {
        seller= value.data();
        print(seller);
        setState(() {
          });
      }).catchError((e)
      {
        print('-------> error ${e.toString()}');
      });

  }
}
