import 'dart:developer';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:go_share/Product.dart';
import 'package:go_share/User.dart';
import 'control.dart';
import 'Product.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
var colors = creatingColors();
class SellerProfile extends StatefulWidget {
  @override
  _SellerProfileState createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
  @override
  List comments=[];
  List rating=[];
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:PreferredSize(
          preferredSize: Size.fromHeight(40.0), child:AppBar(iconTheme: IconThemeData(color: Colors.black),
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: Colors.white,)),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Column(children: [
                Center(child: userInfo()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 9),
                  child: Container
                    (alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text('Rating and reviews',
                    style: TextStyle(color: Colors.green,fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(width: 10,)
                          ,Icon(Icons.trending_up,size: 20,color: Colors.green[200],)
                        ],
                      )),
                ),
                listOfItemsList()
              ],),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colors[0],
        child: Icon(Icons.star_half_outlined),
      onPressed: _showRatingAppDialog,),
    );
  }
  Container userInfo() {
    return Container(
      alignment: Alignment.topCenter,
      color: Colors.white,
      child: Card(
      shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(10),),
        child: Stack(
          children: [
            Column (
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Opacity(
                        opacity: 0.4,
                        //opening change photo/show photo menu
                        child: profilePicOptions(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:10.0),
                          child: RichText(text: TextSpan(children: [
                            TextSpan(text:'seller name ',
                              style: TextStyle(color: colors[2], fontSize: 15,fontWeight: FontWeight.bold),
                            ),]
                          ),),),
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 5.0),
                        child: Text('seller@gmail.com',
                          style: TextStyle(color: colors[2], fontSize: 12,),
                          ),
                          ),
                          Padding(
                          padding: const EdgeInsets.symmetric(horizontal:10.0),
                          child: RichText(text: TextSpan(children: [
                            WidgetSpan(child: Icon(Icons.location_on_sharp,color: colors[0],size: 18,)),
                            TextSpan(text:'pendik,istanbul',
                            style: TextStyle(color: Colors.blueGrey,fontSize:12,fontWeight: FontWeight.bold ))])),
                              )],
                              ),
                  )
                  ,SizedBox(height: 10,),]),

          ],
        ),
      ),
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
      ],
      onPressed: (){},
      blurBackgroundColor: colors[2],
      child: profilePic(),
    );
  }
  CircleAvatar profilePic(){
    return CircleAvatar(
      radius: 40,
      //ADD A PHOTO HERE!!
      child: Icon(Icons.account_circle,color: colors[2],size: 80,),
      backgroundColor: Colors.transparent,
    );
  }

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: 'Rate this seller',
      message: 'Rating this seller and tell others what you think.'
          ' Add more description here if you want.',
      submitButton: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        rating.add(response.rating);
        comments.add(response.comment);
        setState(() {});
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }

  RatingBar ratingBar(){
    return RatingBar.builder(
        initialRating: 0,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: false,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
    Icons.star,
    color: Colors.amber,
    ),
    onRatingUpdate: (rating) {
    print(rating);
    },);
  }
  Container listOfItemsList(){
    return Container(
      color: Colors.white,

      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: rating.length,
          itemBuilder: (BuildContext context,int index ){
            return GridTile(child: itemList(index));
          },
      ),
    );
  }
  itemList(int index){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          shape: RoundedRectangleBorder(
              side: new BorderSide(color: Colors.green, width: 1.0),
              borderRadius: BorderRadius.circular(4.0)),
          child: Container(child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                  CircleAvatar(
                  radius: 20,
                  //ADD A PHOTO HERE!!
                  child: Icon(Icons.account_circle,color: colors[2],size: 40,),
                  backgroundColor: Colors.transparent,),
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('User name',style: TextStyle(color:Colors.green,fontWeight: FontWeight.bold),),
                      ),

                    ],)
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(4.0),
                child: RatingBarIndicator(
                  rating: rating[index].toDouble(),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(comments[index]),
              )
            ],
          ),)
        ),
      ),
    );
  }
  CircleAvatar pic(){
    return CircleAvatar(
      radius: 40,
      //ADD A PHOTO HERE!!
      child: Icon(Icons.account_circle,color: colors[2],size: 80,),
      backgroundColor: Colors.transparent,
    );
  }
}
List creatingColors() {
  var colors = [];
  colors.add(Color(0xff669966));
  colors.add(Color(0xffffcc00));
  colors.add(Color(0xff333333));
  return colors;
}