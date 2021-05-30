import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'User.dart';
import 'Product.dart';
class Control{
  List<User>users=[];
  Control(){
  creat();
  }
  void creat(){
    for (int i=0;i<10;i++){
      User user=new User();
      user.firstName="Esraa";
      user.lastName="Torky"+i.toString();
      user.mail=user.firstName+"@gmail.com";
      user.points=100;
      user.city="istanbul";
      user.neighborhood="pendik";
      this.users.add(user);
  }


  }
}