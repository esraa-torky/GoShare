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
            crossAxisCount: 1,
            childAspectRatio: 4,
            mainAxisSpacing: 10,
            children: [
              ...products.map((product) => TextButton(
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.text * 5,
                      ),
                      alignment: Alignment.center,
                      primary: Colors.white,
                      backgroundColor: Colors.blue[400],
                      side: BorderSide(
                        color: Colors.blue[400],
                        width: 2,
                      ),
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onPressed: () async {
                      var productProvider =
                          Provider.of<ProductProvider>(context, listen: false);
                      productProvider.setTempProduct(product);

                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ProductItem()));
                    },
                    child: Text(
                      product['name'],
                      textAlign: TextAlign.center,
                    ),
                  ))
            ],
          )
        : Center(
            child: Text(
              'Product not found',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.text * 5,
              ),
            ),
          );
  }
}
