import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
var colors = creatingColors();
class SellerProfile extends StatefulWidget {
  @override
  Map seller;
  SellerProfile({this.seller});
  _SellerProfileState createState() => _SellerProfileState(seller: this.seller);
}

class _SellerProfileState extends State<SellerProfile> {
  @override
  List allReviews = [];
  List userWhoReview = [];
  Map seller;
  var check;

  _SellerProfileState({this.seller});

  void initState() {
    getReviews();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(iconTheme: IconThemeData(color: Colors.black),
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 9),
                child: Container
                  (alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text('Rating and reviews',
                          style: TextStyle(color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),),
                        SizedBox(width: 10,)
                        , Icon(Icons.trending_up, size: 20, color: Colors
                            .green[200],)
                      ],
                    )),
              ),
              check != null ? listOfReviewsList()
                  : Center(child: CircularProgressIndicator())
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
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Opacity(
                        opacity: 0.4,
                        //opening show photo
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
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: RichText(text: TextSpan(children: [
                            TextSpan(text: seller['user_name'],
                              style: TextStyle(color: colors[2],
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]
                          ),),),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Text(seller['email'],
                            style: TextStyle(color: colors[2], fontSize: 12,),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: RichText(text: TextSpan(children: [
                            WidgetSpan(child: Icon(
                              Icons.location_on_sharp, color: colors[0],
                              size: 18,)),
                            TextSpan(text: seller['city'] + " " +
                                seller['neighbourhood'],
                                style: TextStyle(color: Colors.blueGrey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold))
                          ])),
                        )
                      ],
                    ),
                  )
                  , SizedBox(height: 10,),
                ]),

          ],
        ),
      ),
    );
  }

  FocusedMenuHolder profilePicOptions() {
    return FocusedMenuHolder(
      menuWidth: MediaQuery
          .of(context)
          .size
          .width * 0.5,
      openWithTap: true,
      //NOT DONE YET !!!!
      menuItems: [
        FocusedMenuItem(title: Text('View profile picture'),
            trailingIcon: Icon(Icons.face, color: colors[2],),
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (_)
              =>
                  ImageDialog(seller['image'])
              );
            }
        ),
      ],
      onPressed: () {},
      blurBackgroundColor: colors[2],
      child: profilePic(),
    );
  }

  CircleAvatar profilePic() {
    return CircleAvatar(
      radius: 40,
      backgroundImage: seller['image'].length != 0 ? NetworkImage(
          seller['image'])
          : NetworkImage(
          'https://icons-for-free.com/iconfiles/png/512/person-1324760545186718018.png'),
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
        addRating(response.rating, response.comment);
        setState(() {});
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }

  RatingBar ratingBar() {
    return RatingBar.builder(
      initialRating: 0,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) =>
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
      onRatingUpdate: (rating) {
        print(rating);
      },);
  }

  Container listOfReviewsList() {
    return Container(
      color: Colors.white,

      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: allReviews.length,
        itemBuilder: (BuildContext context, int index) {
          return GridTile(child: itemList(index));
        },
      ),
    );
  }

  itemList(int index) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
            shape: RoundedRectangleBorder(
                side: new BorderSide(color: Colors.green, width: 1.0),
                borderRadius: BorderRadius.circular(4.0)),
            child: Container(child: Column(
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

                        backgroundImage: //userWhoReview[index]['image'].length != 0?NetworkImage(userWhoReview[index]['image'])
                        // :
                        NetworkImage(
                            'https://icons-for-free.com/iconfiles/png/512/person-1324760545186718018.png'),),
                      Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('user name'
                            // userWhoReview[index]['user_name'].toString()
                            , style: TextStyle(color: Colors.green,
                                fontWeight: FontWeight.bold),),
                        ),

                      ],)
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: RatingBarIndicator(
                    rating: allReviews[index]['rating'].toDouble(),
                    itemBuilder: (context, index) =>
                        Icon(
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
                  child: Text(allReviews[index]['review']),
                )
              ],
            ),)
        ),
      ),
    );
  }


  getReviews() async {
    final snapshot = await FirebaseFirestore.instance.collection('Users').doc(
        seller['uid']).collection('reviews').get();

    allReviews = snapshot.docs.map((doc) => doc.data()).toList();
    //userWhoReview=
    // CollectionReference users = FirebaseFirestore.instance.collection('Users');
    // userWhoReview.clear();
    // for (var i in allReviews){
    //   users.doc(i['reviewerId']).get().then((value) => userWhoReview.add(value));
    // }
    // print(userWhoReview);
    check = true;
    setState(() {

    });
  }

  addRating(rate, review) async {
    await SharedPreferences.getInstance().then((value) {
      var id = value.getString('userID');
      FirebaseFirestore.instance.collection('Users').doc(seller['uid'])
          .collection('reviews').add({
        'reviewerId': id,
        'rating': rate,
        'review': review,
      });
      getReviews();
      setState(() {});
    }
    );
  }
}
  class ImageDialog extends StatefulWidget {
  @override
  String image;
  ImageDialog(this.image);
  _ImageDialogState createState() => _ImageDialogState(this.image);
  }

  class _ImageDialogState extends State<ImageDialog> {
  String image;
  _ImageDialogState(this.image);
  @override
  Widget build(BuildContext context,) {
  return Dialog(
  child: Container(
  width:  MediaQuery.of(context).size.width*0.5,
  height:  MediaQuery.of(context).size.height*0.5,
  decoration: BoxDecoration(
  image: DecorationImage(
  image: NetworkImage(image),
  fit: BoxFit.cover
  )
  ),
  ),
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