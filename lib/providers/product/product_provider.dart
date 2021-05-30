import 'package:flutter/cupertino.dart';

class ProductProvider extends ChangeNotifier {
  String title = 'PRODUCTS';
  TextEditingController searchController = TextEditingController(text: '');
  String incomingCategoryName;
  Map<String, dynamic> tempProduct;
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> filteredProducts = [];
  void setProduct(val) {
    products = val;
    filteredProducts = val;
    notifyListeners();
  }

  void searchProduct(val) {
    if (val != '') {
      filteredProducts = products
          .where((product) =>
              product['name'].toUpperCase().contains(val.toUpperCase()))
          .toList();
    } else {
      filteredProducts = products;
    }
    notifyListeners();
  }

  void setIncomingCategoryName(val) {
    incomingCategoryName = val;
    notifyListeners();
  }

  void setTempProduct(val) {
    tempProduct = val;
    notifyListeners();
  }
}
