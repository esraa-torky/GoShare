import 'package:flutter/material.dart';

class Category {
  String categoryName;
  List<Map<String, dynamic>> products;
  String categoryImage;
  Category(String _categoryName, List<Map<String, dynamic>> _products, String _categoryImage) {
    this.categoryName = _categoryName;
    this.products = _products;
    this.categoryImage = _categoryImage;


  }
}
