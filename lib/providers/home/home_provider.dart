import 'package:flutter/cupertino.dart';
import 'package:go_share/models/Category.dart';

class HomeProvider extends ChangeNotifier {
  String title = 'CATEGORIES';
  TextEditingController searchController = TextEditingController(text: '');
  List<Category> categories = [
    Category('ELECTRONICS', [
      {
        'name': 'Printer 1',
        'image': 'images/electronics/printer1.jpg',
        'price': 5000,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
      {
        'name': 'Printer 2',
        'image': 'images/electronics/printer2.jpg',
        'price': 2000,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
      {
        'name': 'Printer 3',
        'image': 'images/electronics/printer3.jpg',
        'price': 3000,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
      {
        'name': 'Printer 4',
        'image': 'images/electronics/printer4.jpg',
        'price': 4000,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      }
    ]),
    Category('TELEPHONE', [
      {
        'name': 'Samsung S6',
        'image': 'images/telephone/samsungs6.jpg',
        'price': 1000,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
      {
        'name': 'Samsung S7',
        'image': 'images/telephone/samsungs7.jpg',
        'price': 2000,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
      {
        'name': 'Iphone 8',
        'image': 'images/telephone/iphone8.jpg',
        'price': 7000,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
      {
        'name': 'Iphone X',
        'image': 'images/telephone/iphonex.jpg',
        'price': 10000,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
    ]),
    Category('CLOTHING', [
      {
        'name': 'T-Shirt',
        'image': 'images/wear/tshirt1.jpg',
        'price': 40,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
      {
        'name': 'Trouser',
        'image': 'images/wear/trouser1.jpg',
        'price': 35,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
    ]),
    Category('WHITE GOODS', [
      {
        'name': 'Washing machine',
        'image': 'images/whitegoods/washingmachine1.jpg',
        'price': 4000,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
      {
        'name': 'Dishwasher',
        'image': 'images/whitegoods/dishwasher1.jpg',
        'price': 3500,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
    ]),
  ];
  List<Category> filteredCategories = [
    Category('Electronics', [
      {
        'name': 'Printer 1',
        'image': 'images/electronics/printer1.jpg',
        'price': 5000,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
      {
        'name': 'Printer 2',
        'image': 'images/electronics/printer2.jpg',
        'price': 2000,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
      {
        'name': 'Printer 3',
        'image': 'images/electronics/printer3.jpg',
        'price': 3000,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
      {
        'name': 'Printer 4',
        'image': 'images/electronics/printer4.jpg',
        'price': 4000,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      }
    ]),
    Category('Telephone', [
      {
        'name': 'Samsung S6',
        'image': 'images/telephone/samsungs6.jpg',
        'price': 1000,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
      {
        'name': 'Samsung S7',
        'image': 'images/telephone/samsungs7.jpg',
        'price': 2000,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
      {
        'name': 'Iphone 8',
        'image': 'images/telephone/iphone8.jpg',
        'price': 7000,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
      {
        'name': 'Iphone X',
        'image': 'images/telephone/iphonex.jpg',
        'price': 10000,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
    ]),
    Category('Wear', [
      {
        'name': 'T-Shirt',
        'image': 'images/wear/tshirt1.jpg',
        'price': 40,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
      {
        'name': 'Trouser',
        'image': 'images/wear/trouser1.jpg',
        'price': 35,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
    ]),
    Category('White Goods', [
      {
        'name': 'Washing machine',
        'image': 'images/whitegoods/washingmachine1.jpg',
        'price': 4000,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
      {
        'name': 'Dishwasher',
        'image': 'images/whitegoods/dishwasher1.jpg',
        'price': 3500,
        'desc':
            'aaaaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaaa aaaa aaaa aaaa aaaaaa aaaa aaaaa aaaaa aaaa aaaaa aaa'
      },
    ]),
  ];

  void searchCategories(val) {
    if (val != '') {
      filteredCategories = categories
          .where((category) =>
              category.categoryName.toUpperCase().contains(val.toUpperCase()))
          .toList();
    } else {
      filteredCategories = categories;
    }
    notifyListeners();
  }
}
