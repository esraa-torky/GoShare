import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_share/core/util/init/helper/size_config.dart';
import 'package:go_share/providers/product/product_provider.dart';
import 'package:go_share/views/product/product_item.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  const ProductList({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return products.isNotEmpty
        ? GridView.count(
            physics: BouncingScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              ...products.map((product) => TextButton(

                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/' + product['image'],),
                        fit: BoxFit.fill
                    ),

                  ),
                  //child: Text(category.categoryName,),


                ),

                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.text * 5,
                      ),
                      alignment: Alignment.center,
                      primary: Colors.white,
                      backgroundColor: Color(0xff669966),
                      side: BorderSide(
                        color: Color(0xff669966),
                        width: 0.1,
                      ),
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(1))),
                    ),
                    onPressed: () async {
                      var productProvider =
                          Provider.of<ProductProvider>(context, listen: false);
                      productProvider.setTempProduct(product);

                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ProductItem()));
                    },

                  ))
            ],
          )
        : Center(
            child: Text(
              'Product not found',
              style: TextStyle(
                fontFamily: 'QuickSand',
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.text * 5,
              ),
            ),
          );
  }
}
