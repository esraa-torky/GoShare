import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_share/core/util/init/helper/size_config.dart';
import 'package:go_share/providers/product/product_provider.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('GoShare'),
        backgroundColor: Color(0xff669966),
      ),
      body: Consumer<ProductProvider>(
        builder: (ctxHome, product, child) => SafeArea(
          child: Container(
            color: Colors.grey[200],
            child: MediaQuery.of(context).size.width >= 800 && isLandscape
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .5,
                            height: MediaQuery.of(context).size.height * .85,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                border: Border.all(
                                    width: 2, color: Colors.grey[200])),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.asset(
                                'assets/${product.tempProduct['image']}',
                                width: MediaQuery.of(context).size.width * .3,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                Container(
                                  child: Text(
                                    '${product.tempProduct['name']}',
                                    style: TextStyle(
                                      fontFamily: 'QuickSand',
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '\$${product.tempProduct['price']}',
                                    style: TextStyle(
                                      fontFamily: 'QuickSand',
                                      fontSize: 30,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    '${product.tempProduct['desc']}',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Ubuntu',
                                      fontSize: 30,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: TextButton.icon(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.shopping_cart_sharp,
                                      color: Colors.white,
                                      size: SizeConfig.text * 5,
                                    ),
                                    style: ButtonStyle(
                                      alignment: Alignment.center,
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xff669966)
                                          ),
                                    ),
                                    label: Text(
                                      'Add to Cart',
                                      style: TextStyle(
                                        color: Color(0xffffcc00),
                                        fontFamily: 'Ubuntu',
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeConfig.text * 3,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                : ListView(
                    padding: EdgeInsets.only(left: 60, right: 60),
                    physics: BouncingScrollPhysics(),
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            border:
                                Border.all(width: 2, color: Colors.grey[200])),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.asset(
                            'assets/${product.tempProduct['image']}',
                            width: MediaQuery.of(context).size.width * .3,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(top: SizeConfig.maxHeight * .05),
                        child: Text(
                          '${product.tempProduct['name']}',
                          style: TextStyle(
                            fontFamily: 'QuickSand',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          '\$${product.tempProduct['points']}',
                          style: TextStyle(
                            fontFamily: 'QuickSand',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          '${product.tempProduct['desc']}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'QuickSand',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.shopping_cart_sharp,
                            color: Colors.white,
                            size: SizeConfig.text * 5,
                          ),
                          style: ButtonStyle(
                              alignment: Alignment.center,
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff333333)),
                              shape: MaterialStateProperty.all(
                                BeveledRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2))),
                              )),
                          label: Text(
                            'Add to Cart',
                            style: TextStyle(
                              color: Color(0xffffcc00),
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.text * 3,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
