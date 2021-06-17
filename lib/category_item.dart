import 'package:flutter/material.dart';
import 'package:go_share/Home_page.dart';
import 'package:go_share/item.dart';

class CategoryItem extends StatefulWidget {
  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          children:<Widget> [
            IconButton(icon: Icon(Icons.arrow_back,
                color: Colors.green),
              onPressed: ()
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage();
                    },
                  ),
                );
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: TextFormField(
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        hintText: 'Search',
                        fillColor: Colors.grey[300],
                        filled: true,
                        prefixIcon: Icon(Icons.search,color: Colors.green,),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                    validator: (name){
                      if(name.isEmpty)
                      {
                      }
                      return null;
                    }
                ),
              ),
            ),

          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget> [
              Text('Category name',style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 20
              ),
              ),
              SizedBox(height: 12,),
              new GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: 10,
                scrollDirection: Axis.vertical,
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10,mainAxisSpacing: 12,),
                itemBuilder: (BuildContext context, int index) => itemcard()
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget itemcard()=>Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18.0),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.green,
          blurRadius: 2.0,
          spreadRadius: 0.0,
          offset: Offset(2.0, 2.0), // shadow direction: bottom right
        )
      ],
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: TextButton(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children:<Widget> [
          Expanded(child: Image.network('https://www.narscosmetics.eu/dw/image/v2/BCMQ_PRD/on/demandware.static/-/Sites-itemmaster_NARS/default/dw773e6329/hi-res/NARS_FA19_Lipstick_Soldier_LPS_Raw_Seduction_Satin_GLBL_B_square.jpg?sw=856&sh=750&sm=fit',fit: BoxFit.fitWidth,)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget> [
                Text('Category name',style: TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 14
                ),
                ),
                Text('20 Points',style: TextStyle(
                    color: Colors.grey,fontSize: 12
                ),
                ),
              ],
            ),
          ),
        ],
      ),
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Item();
            },
          ),
        );
      },
    ),
  );
}
