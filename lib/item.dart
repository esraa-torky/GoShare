import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_share/category_item.dart';
import 'package:go_share/chat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Item extends StatefulWidget {
  @override
  String id,type;
  Item({this.id,this.type});
  _ItemState createState() => _ItemState(id:this.id,type: this.type);
}

class _ItemState extends State<Item> {
  Map itemDataMap;
  String id,type;
  _ItemState({this.id,this.type});
  // void initState()
  // {
  //   getData();
  //   super.initState();
  // }
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
      ,body: //itemDataMap != null?
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
               child: Carousel(
                   images: [
                     NetworkImage('https://i5.walmartimages.com/asr/af62269a-da71-4283-be61-b9638d449449_1.b2811d9a8abd43a686bb3e347a75b31b.jpeg?odnWidth=612&odnHeight=612&odnBg=ffffff'),
                     NetworkImage('https://www.wigglestatic.com/product-media/100375136/Brand-X-Road-Bike-Road-Bikes-Black-2017-BRNDXROADXL-0.jpg?w=1200&h=1200&a=7'),
                   ],
                 dotSize: 4.0,
                 dotSpacing: 15.0,
                 dotColor: Colors.green,
                 indicatorBgPadding: 5.0,
                 dotBgColor: Colors.transparent,
                 borderRadius: true,
               ),
              ),
              SizedBox(height: 15),
              Text('item name'
                //itemDataMap['name']
                ,style: TextStyle(
                  color: Colors.grey,fontSize: 14
              ),
              ),
              SizedBox(height: 10),
              Text('90'
                //itemDataMap['points'].toString()
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
              Text(//itemDataMap['description']
                  'adadghjk asdfhr sdfghjkl aaaaaa druur',
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
                    child: CircleAvatar(backgroundImage: NetworkImage('https://icons-for-free.com/iconfiles/png/512/person-1324760545186718018.png'),
                    backgroundColor: Colors.transparent,
                    ),
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget> [
                    Text('User Name',style: TextStyle(
                        color: Colors.black,fontSize: 14
                    ),
                    ),
                     RatingBar.builder(
                       initialRating: 3,
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
                  child: RaisedButton.icon(
                    onPressed: () async {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Chat();
                          },
                        ),
                      );
                    },
                    disabledColor: Colors.green,
                      icon:Icon(Icons.chat,color: Colors.white,),
                      label: Text("Contact Me",style: TextStyle(
                          color: Colors.white, fontSize: 16.0))
                  ),
                ),
              ),
            ],
           ),
         ),
      )//: Center(child: CircularProgressIndicator())
    );

  }
  getData() async
  {
    CollectionReference type = FirebaseFirestore.instance.collection('CLOTHES');


      type.doc(id).get().then((value)
      {
        itemDataMap = value.data();
        setState(() {
          print(itemDataMap);
        });
      }).catchError((e)
      {
        print('-------> error ${e.toString()}');
      });

  }
}
