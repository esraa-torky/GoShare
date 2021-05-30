
import 'package:flutter/cupertino.dart';
import 'package:go_share/Product.dart';
import 'Product.dart';
class User{
  String firstName;
  String lastName;
  String password;
  String mail;
  int points;
  String city;
  String neighborhood;

  List<Product> userProducts=[];
  User(){

    //addProducttolist(0);
  }
  void addProduct(String name, String type, String price, String description,String image){
    Product product =new Product();
    product.name=name;
    product.price=price;
    product.type=type;
    product.image=image;
    product.description=description;
    this.userProducts.add(product);
  }
  void addProducttolist(int i){
    this.addProduct('Product'+i.toString(), 'clothes', (i+100).toString(),'this should be a cool product or we will kick you out of our app','images/user.png');
  }
}