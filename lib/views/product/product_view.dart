import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_share/common/widgets/search_widget.dart';
import 'package:go_share/common/widgets/title_widget.dart';
import 'package:go_share/providers/product/product_provider.dart';
import 'package:go_share/views/product/layouts/product_list.dart';
import 'package:provider/provider.dart';

class ProductView extends StatelessWidget {
  const ProductView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('GoShare'),
        backgroundColor: Color(0xff669966),
      ),
      body: Consumer<ProductProvider>(
        builder: (ctxHome, product, child) => SafeArea(
          child: Column(
            children: [
              titleWidget(product.title, Color(0xff333333),
                  categoryName: product.incomingCategoryName,),
              SearchWidget(
                searchController: product.searchController,
                search: product.searchProduct,
              ),
              Expanded(
                  child: ProductList(
                products: product.filteredProducts,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
