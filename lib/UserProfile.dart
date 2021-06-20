import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Home_page.dart';
var colors = creatingColors();




class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}
class _UserProfileState extends State<UserProfile> {
  @override
  Map userDataMap;
  File imageFile;
  String path,id,categoryName,pname,price,description;
  File productImage;
  String dropdownValue = "choose the item category";
  List products=[];

  void initState()
  {
    getData();
    getProducts();
    super.initState();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.grey[100],

          bottomNavigationBar:BottomAppBar (
            color: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: colors[0],
                      child: IconButton(icon: Icon(Icons.home,size: 20,color: Colors.white,)
                          , onPressed: () {Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
                              },
                            ),
                          );}),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: colors[0],
                      child: IconButton(icon: Icon(Icons.add,color: Colors.white,size: 20,)
                          , onPressed: () {
                            showDialog(context: context, builder:(context) {
                              return addProductDialog(context);
                            });

                          })
                          ),
                    ),

                ],
              ),
            ),
          ),
          body: userDataMap != null?
            Column(
              children: [
                Stack(
                children: [
                Column(
                children: [
                  SizedBox(
                      width:MediaQuery.of(context).size.width ,
                      height:150,
                      child: Image.asset('assets/images/copy.png',fit:BoxFit.fitWidth)),
                   userInfo(),
                   ],
                ),
                  Positioned(top:120,left:MediaQuery.of(context).size.width*0.40,
                      child: profilePicOptions()),
                ],
                ),
                  Container(height:90 ,
                      child: itemsViewBar()),
                  Expanded(child: Column(
                  children: [
                  itamsView(),
                  ],
                  ),)

              ],)
              : Center(child: CircularProgressIndicator())
            )
    ,);



  }


//display the profile photo and user name
  Container userInfo() {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.bottomCenter,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Row (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget>[
                  //number of items
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Items",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: colors[0],fontFamily: 'QuickSand'),),
                      Text(userDataMap['items number'].toString(),
                        style: TextStyle(color: Colors.grey,fontSize: 18),)
                    ],
                  ),

                  //number of points
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Points",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: colors[0],fontFamily: 'QuickSand'),),
                      Text(userDataMap['points'].toString(),style: TextStyle(color: Colors.grey,fontSize: 18),)
                    ],
                  ),
                ]),
          ),
          //user info (name /location/email)
          Center(child: userData()),
        ],),);
  }
  Container userData(){
    return Container(

      alignment: FractionalOffset.center,
      height: MediaQuery.of(context).size.width*0.25,
      child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Text(userDataMap['user_name'],
            style: TextStyle(color: Colors.black54, fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'QuickSand'),
          ),
          SizedBox(height: 10,),
        // Text(userDataMap['email'],
        //   style: TextStyle(color: colors[2], fontSize: 15,),
        // ),
        RichText(text: TextSpan(children: [
          WidgetSpan(child: Icon(Icons.location_on_sharp,color: colors[0],size: 18,)),
          TextSpan(text:userDataMap['city']+','+userDataMap['neighbourhood'],
              style: TextStyle(color: Colors.blueGrey,fontSize:15,fontWeight: FontWeight.bold,fontFamily: 'QuickSand' ))])),]),);
  }
  Align profilePicOptions(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: FocusedMenuHolder(
        menuWidth:  MediaQuery.of(context).size.width*0.5,
        openWithTap: true,
        //NOT DONE YET !!!!
        menuItems: [
          FocusedMenuItem(title: Text('View profile picture'),
            trailingIcon: Icon(Icons.face,color: colors[2],),
          ),
          FocusedMenuItem(title: Text('Change profile picture'),
            trailingIcon: Icon(Icons.image,color: colors[2],),
            onPressed: (){
            selectImage();
            }
          ),
        ],
        onPressed: (){},
        blurBackgroundColor: colors[2],
        child: profilePic(),
      ),
    );
  }
  // profile pic as an icon
  CircleAvatar profilePic(){
    return CircleAvatar(
      radius: 42,
       backgroundColor: Colors.green[400],
      child: CircleAvatar(
        radius: 40,
        backgroundImage:imageFile !=null ? FileImage(imageFile)
            :userDataMap['image'].length != 0?NetworkImage(userDataMap['image'])
            :NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQtYyNP9njaEeggRjQ5MjX2PrJy1OHkN_o-FA&usqp=CAU')
        ,
        backgroundColor:Colors.transparent,
      ),
    );
  }

  //end of user info widgets and functions
  //tab bar
  AppBar itemsViewBar(){
    return AppBar(
      backgroundColor: Colors.grey[100],
      bottom: TabBar(tabs: [Tab(icon: Icon(Icons.grid_view,color: colors[0],),),
        Tab(icon: Icon(Icons.view_day_rounded,color: colors[0],))]),
    )
    ;
  }
  Expanded itamsView(){
    return Expanded(child:
    TabBarView(
      children: [Expanded(child: listOfItemsGrid()),Expanded(child: listOfItemsList()),],
    ),);
  }
  Container listOfItemsGrid(){
    if (products.isEmpty){
      return Container();
    }
    return Container(
      color: Colors.grey[100],
      child: GridView.builder(itemCount: products.length,
          //physics: NeverScrollableScrollPhysics(),
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0  )
          , itemBuilder: (BuildContext context,int index ){
            return GridTile(child:FocusedMenuHolder(
              menuWidth:  MediaQuery.of(context).size.width*0.5,
              openWithTap: true,
              menuItems: [
                FocusedMenuItem(title: Text('Edit'),
                    trailingIcon: Icon(Icons.edit_outlined,color: colors[2],),
                    onPressed:(){ showDialog(context: context, builder:(context) {
                      return edit(context, index);
                    });}
                ),
                FocusedMenuItem(title: Text('Delete'),
                    trailingIcon: Icon(Icons.delete,color: colors[2],),
                    onPressed: (){delete(index);}),
              ],
              onPressed: (){},
              blurBackgroundColor: colors[2],
              child:itemGrid(products[index]['image']),),);
          }),
    );
  }
  Container listOfItemsList(){
    return Container(
      color: Colors.grey[100],
      child: ListView.separated(
          itemCount: products.length,

          itemBuilder: (BuildContext context,int index ){
            return GridTile(
                child: itemList(index));
          },
          separatorBuilder: (context, index) {
            return Divider();
          }),
    );
  }
  Card itemGrid(String image){
    return Card(child: Container(child:Image.network('https://i.pinimg.com/564x/9c/ec/cd/9ceccd67b51eec22ebe7079e0063eed9.jpg')));
  }
  Card itemList(int index){
    return Card(
      child: Container(width: 80,height:MediaQuery.of(context).size.height*0.35,
        child: Column(children:<Widget> [
          Expanded(
            child: Stack(
              children:<Widget> [
                SizedBox.expand(child: Image.network('https://i.pinimg.com/564x/9c/ec/cd/9ceccd67b51eec22ebe7079e0063eed9.jpg')),
                Container(
                  alignment: Alignment.topRight,
                  child: optionsMenu(index),),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(

                      width:MediaQuery.of(context).size.width*0.12 ,
                      height:MediaQuery.of(context).size.height*0.05 ,
                      child:Center(
                        child: RichText(text: TextSpan(children: [
                          TextSpan(text:
                          products[index]['points'].toString(),
                            style: TextStyle(color: Colors.green, fontSize: 15,fontWeight: FontWeight.bold),
                          ),
                          WidgetSpan(child:Icon( Icons.monetization_on_outlined,color: Colors.green,
                              size: 15),),]
                        ),),
                      ),
                    ),
                  ),
                )],

            ),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(alignment: Alignment.bottomLeft,
              child: Text((products[index]['name']+"|"+products[index]['category']),
                style: TextStyle(fontWeight: FontWeight.bold,color:colors[0],fontSize: 18 ),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(alignment: Alignment.bottomLeft,
              child: Text(products[index]['description'],
                style: TextStyle(color:Colors.grey,fontSize: 15 ),),
            ),
          )
        ],),),
    );
  }
  PopupMenuButton optionsMenu(int index){
    return PopupMenuButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
          PopupMenuItem(
            child: ListTile(
              onTap: (){
                showDialog(context: context, builder:(context) {
                  return edit(context, index);
                });
              },
              leading: Icon(Icons.edit_outlined),
              title: Text('Edit'),
            ),),
          PopupMenuItem(
            child: ListTile(
              onTap: (){delete(index);},
              leading: Icon(Icons.delete),
              title: Text('Delete'),
            ),
          ),])
    ;
  }
  void delete(int index){
    //users[0].userProducts.removeAt(index);
    setState(() {
    });
  }
  SimpleDialog edit(BuildContext context,int index){
    return SimpleDialog(
      title: Text('Edit product info',style: TextStyle(color: colors[2]),),
      children: [
        SimpleDialogItem(
          text: 'Name',
          size: 40,
          child: TextField(
            onChanged: (value) {
              pname=value;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText:products[index]['name'],),
          ),
        ),
        SimpleDialogItem(
          text: 'Price',
          size: 40,
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              price=value;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText:products[index]['points'],),
          ),
        ),
        SimpleDialogItem(text:'Category',
          child: DropdownSearch<String>(
              mode: Mode.MENU,
              popupBarrierColor: Colors.green,
              showSelectedItem: true,
              items: ['ELECTRONICS','CLOTHES','HOME AND GARDENING','FILM','SPORTS'],
              hint: "choose the item category",
              popupItemDisabled: (String s) => s.startsWith('I'),
              onChanged:(String data) {categoryName= data;},
              selectedItem: products[index]['category']),
        ),
        SimpleDialogItem(
          text: 'Description',
          size:100,
          child: TextField(
            onChanged: (value) {
              description=value;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              //errorStyle: ,
              labelText:products[index]['description'],),
          ),
        ),
        MaterialButton(elevation: 5.0,
            child: Text('Submit',style: TextStyle(color: colors[0]),),
            onPressed: (){

              //addNewProduct(categoryName, customeController1.text.toString(), customeController2.text.toString(), customeController.text.toString());
              setState(() {});
            }),
      ],
    );
  }
  addProductDialog(BuildContext context){
    return SimpleDialog(
        title: Text('Edit product info',style: TextStyle(color: colors[2]),),
        children: [
          SimpleDialogItem(
            text: 'Name',
            size: 40,
            child: TextField(
              onChanged: (value) {
                pname=value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SimpleDialogItem(
            text: 'Price',
            size: 40,
            child: TextField(
              onChanged: (value) {
                price=value;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SimpleDialogItem(
            text:'Category',
            child:
            DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItem: true,
                items: ['ELECTRONICS','CLOTHES','HOME AND GARDENING','FILM','SPORTS'],
                hint: "choose the item category",
                popupItemDisabled: (String s) => s.startsWith('I'),
                onChanged:(String data) {
                  categoryName=data;
                }),)
          ,
          SimpleDialogItem(
            text: 'Description',
            size:100,
            child: TextField(
              onChanged: (value) {
                description=value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                //errorStyle: ,
              ),
            ),
          ),
          
          MaterialButton(elevation: 5.0,
            child: Text('Next',style: TextStyle(color: colors[0]),),
            onPressed: (){
              Navigator.of(context).pop();

              var productid =addNewProduct(categoryName, pname, description, price);
              showDialog(context: context, builder:(context) {
                return addImage(context,productid);
              });
            },
          ),]);
  }
  addImage(context,productid){
    return SimpleDialog(
        title: Text('Edit product info',style: TextStyle(color: colors[2]),),
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextButton(child: Row(
              children: [
                Text('Add image of the item',style: TextStyle(color: Colors.green),),
                SizedBox(width: 20,),
                Icon(Icons.add_a_photo,color: Colors.green,)
              ],
            ),
            onPressed: () async {
              final selectedImage = await ImagePicker().getImage(source: ImageSource.gallery);
              productImage = File(selectedImage.path);
              setState(() {

              });

            },),
          ),
          MaterialButton(elevation: 5.0,
              child: Text('Add',style: TextStyle(color: colors[0]),),
              onPressed: (){
            firebase_storage.FirebaseStorage.instance
                .ref()
                .child('${productImage.uri.pathSegments[productImage.uri.pathSegments.length - 1]}')
                .putFile(productImage).onComplete.then((value) async
            {
            await value.ref.getDownloadURL().then((value)
            {
            CollectionReference users = FirebaseFirestore.instance.collection('Users');
        
            users.doc(id).collection('products').doc(productid).update({
            'image': value.toString(),
            }).then((value)
            {
            getData();
            }).catchError((error)
            {
            print(error.toString());
            });
            });
            });
            setState(() {});
              }),
        ],);
  }


  getData() async
  {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    await SharedPreferences.getInstance().then((value)
    {
      id = value.getString('userID');
      users.doc(id).get().then((value)
      {
        userDataMap = value.data();
        setState(() {

        });
      }).catchError((e)
      {
        print('-------> error ${e.toString()}');
      });
    });
  }
  getProducts() async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    await SharedPreferences.getInstance().then((value)
    {
      id = value.getString('userID');
      users.doc(id).collection('products').get().then((value) =>
        products=value.docs.map((doc) => doc.data()).toList()
      );
    });
    setState(() {

    });
  }
  selectImage() async
  {
    final selectedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    imageFile = File(selectedImage.path);
    setState(() {

    });
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('${imageFile.uri.pathSegments[imageFile.uri.pathSegments.length - 1]}')
        .putFile(imageFile).onComplete.then((value) async
    {
      await value.ref.getDownloadURL().then((value)
      {
        CollectionReference users = FirebaseFirestore.instance.collection('Users');

        users.doc(id).update({
          'image': value.toString(),
        }).then((value)
        {
          getData();
        }).catchError((error)
        {
          print(error.toString());
        });
      });
    });

  }
  addNewProduct( category, name, description, price){
    var productId;
    FirebaseFirestore.instance.collection(category).add({
      'name': name,
      'description':description,
      'points':int.parse(price),
      'image':'',
      'sellerId':id,
      'pId':'',
      }).then((value) {
      FirebaseFirestore.instance.collection(category).doc(value.id).update({'pId': value.id

      });
      FirebaseFirestore.instance.collection('Users').doc(id).collection('products').doc(value.id).set({
        'category':category,
        'pId':value.id,
        'name': name,
        'description':description,
        'points':int.parse(price),
        'image':'',
      });
        productId=value;
      });

    setState(() {

    });
    return productId;
  }







}




class SimpleDialogItem extends StatelessWidget {
  const SimpleDialogItem({Key key, this.icon, this.color, this.text, this.onPressed,this.child,this.size})
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
                  style: TextStyle(color:colors[0],fontSize: 18,fontWeight: FontWeight.bold),),
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
List creatingColors() {
  var colors = [];
  colors.add(Color(0xff669966));
  colors.add(Color(0xffffcc00));
  colors.add(Color(0xff333333));
  return colors;
}
