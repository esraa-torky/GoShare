import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:go_share/Product.dart';
import 'package:go_share/User.dart';
import 'control.dart';
import 'Product.dart';
var colors = creatingColors();
Control c=new Control();
List<User>users=c.users;
List<Product> userProduct=users[0].userProducts;
class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}
class _UserProfileState extends State<UserProfile> {
  @override
  int n=0;
  String name=users[0].firstName+' '+users[0].lastName;
  String emailAdd=users[0].mail;
  var pointsNum=users[0].points ;
  String location=users[0].city+","+users[0].neighborhood;
  TextEditingController customeController=TextEditingController();
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: colors[0],
          title: Text('User Profile'),
        ),
        body: Column(
              children: [
                userInfo(),
                SizedBox(height: 50, child: itemsViewBar()),
                Expanded(child: Column(
                  children: [
                    itamsView(),
                  ],
                ),),],
            ),
      ),
    );
  }

//display the profile photo and user name
  Container userInfo() {
    return Container(
      alignment: Alignment.topCenter,
      color: Colors.white,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column (
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                padding: const EdgeInsets.symmetric(horizontal:10.0),
                child: TextButton( onPressed: ()
                  {changeUserName(context).then((onValue){
                name=onValue;});},
                  child: RichText(text: TextSpan(children: [
                      TextSpan(text:name,
                        style: TextStyle(color: colors[2], fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                      WidgetSpan(child:Icon( Icons.create_rounded,color: colors[2],
                            size: 15),),]
                  ),),),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 5.0),
                  child: Text(emailAdd,
                  style: TextStyle(color: colors[2], fontSize: 15,),
                    ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0),
                child: RichText(text: TextSpan(children: [
                  WidgetSpan(child: Icon(Icons.location_on_sharp,color: colors[0],size: 18,)),
                  TextSpan(text:location,
                      style: TextStyle(color: Colors.blueGrey,fontSize:15,fontWeight: FontWeight.bold ))])),
              )
                  ,SizedBox(height: 10,),]),
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Items",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: colors[0]),),
                          Text(userProduct.length.toString(),style: TextStyle(color: Colors.grey,fontSize: 18),)
                        ],
                      ),
                    ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Points",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: colors[0]),),
                      Text(users[0].points.toString(),style: TextStyle(color: Colors.grey,fontSize: 18),)
                    ],
                  ),
                )],),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: colors[0]),
                  onPressed: (){
                    users[0].addProducttolist(n);
                    n++;
                    setState(() {
                    });
                  },
                  icon:Icon(Icons.add),
                  label: Text('Add new item'),), ],
            ),

          ]),
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
        FocusedMenuItem(title: Text('Change profile picture'),
          trailingIcon: Icon(Icons.image,color: colors[2],),
        ),
      ],
      onPressed: (){},
      blurBackgroundColor: colors[2],
      child: profilePic(),
    );
  }
  // profile pic as an icon
  CircleAvatar profilePic(){
    return CircleAvatar(
      radius: 40,
      //ADD A PHOTO HERE!!
      child: Icon(Icons.account_circle,color: colors[2],size: 80,),
      backgroundColor: Colors.transparent,
    );
  }

  changeUserName(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(title: Text('new user name',
        style: TextStyle(color: colors[0]),),
        content: TextField(controller: customeController,),
        actions: [MaterialButton(elevation: 5.0,
            child: Text('Submit',style: TextStyle(color: colors[0]),),
            onPressed: (){
          Navigator.of(context).pop(customeController.text.toString());
            })],
      );
    },);
  }

  AppBar itemsViewBar(){
    return AppBar(
      backgroundColor: Colors.white,
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
    if (userProduct.isEmpty){
      return Container(child: Center(child: Column(children: <Widget>[
        Icon(Icons.add_business,size: MediaQuery.of(context).size.width*0.25,color: colors[1],),
      Text('you didn\'t add any product yet',
        style: TextStyle(color: colors[1],fontSize:20 ), )
      ],),),);
    }
    return Container(
        color: Colors.white,
      child: GridView.builder(itemCount: userProduct.length,
          gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0  )
          , itemBuilder: (BuildContext context,int index ){
            return GridTile(child:FocusedMenuHolder(
                menuWidth:  MediaQuery.of(context).size.width*0.5,
            openWithTap: true,
            menuItems: [
            FocusedMenuItem(title: Text('Edit'),
            trailingIcon: Icon(Icons.edit_outlined,color: colors[2],),
            ),
            FocusedMenuItem(title: Text('Delete'),
            trailingIcon: Icon(Icons.delete,color: colors[2],),
            onPressed: (){users[0].userProducts.removeAt(index);
            setState(() {
            });}),
            ],
            onPressed: (){},
            blurBackgroundColor: colors[2],
            child:itemGrid(userProduct[index].image),),);
          }),
    );
  }

  Container listOfItemsList(){
    return Container(
      color: Colors.white,
      child: ListView.separated(itemCount: userProduct.length,
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
    return Card(child: Container(child:Image.asset(image)));
  }
  Card itemList(int index){
    return Card(
      child: Container(width: 80,height:MediaQuery.of(context).size.height*0.48,
        child: Column(children:<Widget> [
        Expanded(
          child: Stack(
            children:<Widget> [SizedBox.expand(child: Image.asset(userProduct[index].image)),
            Container(
             alignment: Alignment.topRight,
             child: IconButton(onPressed:(){}, icon:Icon(Icons.more_vert) ,)),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  //alignment: Alignment.bottomRight,
                    decoration: BoxDecoration(color: colors[0],
                      borderRadius: BorderRadius.all(Radius.circular(5)),),
                    width:MediaQuery.of(context).size.width*0.15 ,
                  height:MediaQuery.of(context).size.height*0.05 ,
                  child:Center(
                    child: RichText(text: TextSpan(children: [
                      TextSpan(text:userProduct[index].price,
                        style: TextStyle(color: colors[2], fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                      WidgetSpan(child:Icon( Icons.monetization_on_outlined,color: colors[2],
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
            child: Text((userProduct[index].name+"|"+userProduct[index].type),
              style: TextStyle(fontWeight: FontWeight.bold,color:colors[0],fontSize: 20 ),),
          ),
        ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(alignment: Alignment.bottomLeft,
              child: Text(userProduct[index].description,
                style: TextStyle(color:Colors.grey,fontSize: 18 ),),
            ),
          )
        ],),),
    );
  }
}

//creating the app colors
List creatingColors() {
  var colors = [];
  colors.add(Color(0xff669966));
  colors.add(Color(0xffffcc00));
  colors.add(Color(0xff333333));
  return colors;
}
