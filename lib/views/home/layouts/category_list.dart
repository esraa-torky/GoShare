import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_share/core/util/init/helper/size_config.dart';
import 'package:go_share/models/Category.dart';
import 'package:go_share/providers/product/product_provider.dart';
import 'package:go_share/views/product/product_view.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  const CategoryList({Key key, this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return categories.isNotEmpty
        ? GridView.count(
            physics: BouncingScrollPhysics(),
            crossAxisCount: 1,
            childAspectRatio: 4,
            mainAxisSpacing: 10,
            children: [
              ...categories.map((category) => TextButton(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(category.categoryImage,),
                     fit: BoxFit.fill
                    ),

                  ),
                 child: Text(category.categoryName,),


                ),
                style: TextButton.styleFrom(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.text * 5,
                        fontFamily: 'OpenSans',
                      ),
                      alignment: Alignment.center,
                      primary: Colors.white,
                      side: BorderSide(
                        color: Colors.black54,
                        width: 0.5,
                      ),

                    ),

                    onPressed: () async {
                      var productProvider =
                          Provider.of<ProductProvider>(context, listen: false);
                      productProvider.setProduct(category.products);
                      productProvider
                          .setIncomingCategoryName(category.categoryName);
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ProductView()));
                    },

                  ))
            ],
          )
        : Center(
            child: Text(
              'Category not found',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.text * 5,
              ),
            ),
          );
  }
}
