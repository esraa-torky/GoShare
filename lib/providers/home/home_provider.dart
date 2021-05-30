import 'package:flutter/cupertino.dart';
import 'package:go_share/models/Category.dart';

class HomeProvider extends ChangeNotifier {
  String title = 'CATEGORIES';
  TextEditingController searchController = TextEditingController(text: '');
  List<Category> categories = [
    Category('ELECTRONICS', [
      {
        'name': 'HP Printer',
        'image': 'images/electronics/printer1.jpg',
        'price': 5000,
        'desc':
            'Very good conditioned HP Printer. We can deal about point. I also accept trade with Canon Camera.'
      },
      {
        'name': 'Samsung S10',
        'image': 'images/electronics/samsung_s10.jpg',
        'price': 2000,
        'desc':
            'I never used this phone. I can trade this with Iphone X. Send me a message about point.'
      },
      {
        'name': 'Iphone 11 Pro',
        'image': 'images/electronics/iphone_11_pro.jpeg',
        'price': 3000,
        'desc':
            'This product is not available for trade. You can send me message about quaility.'
      },
      {
        'name': 'Samsung Television',
        'image': 'images/electronics/samsung_tv.jpeg',
        'price': 4000,
        'desc':
            'We are moving into another city so this product is available very short time.'
      }
    ], 'assets/images/electronics.png'),

    Category('CLOTHING', [
      {
        'name': 'Mavi T-Shirt',
        'image': 'images/wear/mavi_tshirt.png',
        'price': 40,
        'desc':
        'I wore this tshirt only 2 times and it is not fitting me anymore.'
      },
      {
        'name': 'LTB Jean',
        'image': 'images/wear/ltb_jean.png',
        'price': 35,
        'desc':
        'I bought the wrong size and it is too big for me. We can deal with the point. Send me a message for more detail.'
      },
      {
        'name': 'GAP Sweatshirt',
        'image': 'images/wear/gap_sweatshirt.png',
        'price': 35,
        'desc':
        'I dont like the color od this anymore, you can come to my street to take it. Send me a message about condition.'
      },
    ], 'assets/images/clothing.png'),
    Category('HOME AND GARDENING', [
      {
        'name': 'Samsung Washing machine',
        'image': 'images/whitegoods/samsung_washing_machine.jpeg',
        'price': 4000,
        'desc':
        'We will buy a new washing machine so we want to give this to a student. It works fine.'
      },
      {
        'name': 'Beko Dishwasher',
        'image': 'images/whitegoods/beko_dishwasher.jpeg',
        'price': 3500,
        'desc':
        'We are moving from our house and we want to give it who needs a dishwaher. Send me a message about condition.'
      },

      {
        'name': 'Ikea Wardrobe',
        'image': 'images/whitegoods/ikea_wardrobe.jpeg',
        'price': 3500,
        'desc':
        'This wardrobe is too small for my all clothes, it is not useful for me anymore. It is in a very good condition. You can come and take it.'
      },
      {
        'name': 'Dinner Table',
        'image': 'images/whitegoods/dinner_table.jpeg',
        'price': 3500,
        'desc':
        'This dinner table is so good but it is too big for our new house! We want to give it because we will buy a new smaller one.'
      },

    ], 'assets/images/home_garden.png'),


    Category('FILM', [
      {
        'name': 'Seven DVD',
        'image': 'images/film/seven_dvd.jpeg',
        'price': 40,
        'desc':
        'This movie is the best!'
      },
      {
        'name': 'The Godfather DVD',
        'image': 'images/film/the_godfather_dvd.jpeg',
        'price': 35,
        'desc':
        'I dont need this DVD anymore because there is Netflix!'
      },
    ], 'assets/images/film.png'),

    Category('SPORTS', [
      {
        'name': 'Dumbell',
        'image': 'images/sport/dumbell.jpg',
        'price': 40,
        'desc':
        'I will go to gym for sport so i dont need this in my house anymore.'
      },
      {
        'name': 'Basketball Ball',
        'image': 'images/sport/basketball_ball.jpeg',
        'price': 35,
        'desc':
        'I broke my leg and doctor said that i can not play basketball anymore. Sadly, you can take it whenever you want.'
      },
      {
        'name': 'Football Ball',
        'image': 'images/sport/football_ball.jpeg',
        'price': 35,
        'desc':
        'I will buy a new one so I decided to give this who needs it.'
      },
      {
        'name': 'Bicycle',
        'image': 'images/sport/bicycle.jpeg',
        'price': 35,
        'desc':
        'I had an accident with my motorcycle and I can not use my bicycle. You can take it if you need it.'
      },
      {
        'name': 'Jump Rope',
        'image': 'images/sport/jump_rope.jpeg',
        'price': 35,
        'desc':
        'It is new. I never used this.'
      },

      {
        'name': 'Treadmill',
        'image': 'images/sport/treadmill.jpg',
        'price': 35,
        'desc':
        'It is too noisy for my apartment. You can take it.'
      },
    ], 'assets/images/sport.png'),
  ];
  List<Category> filteredCategories = [
    Category('ELECTRONICS', [
      {
        'name': 'HP Printer',
        'image': 'images/electronics/printer1.jpg',
        'price': 5000,
        'desc':
        'Very good conditioned HP Printer. We can deal about point. I also accept trade with Canon Camera.'
      },
      {
        'name': 'Samsung S10',
        'image': 'images/electronics/samsung_s10.jpg',
        'price': 2000,
        'desc':
        'I never used this phone. I can trade this with Iphone X. Send me a message about point.'
      },
      {
        'name': 'Iphone 11 Pro',
        'image': 'images/electronics/iphone_11_pro.jpeg',
        'price': 3000,
        'desc':
        'This product is not available for trade. You can send me message about quaility.'
      },
      {
        'name': 'Samsung Television',
        'image': 'images/electronics/samsung_tv.jpeg',
        'price': 4000,
        'desc':
        'We are moving into another city so this product is available very short time.'
      }
    ], 'assets/images/electronics.png'),
    Category('CLOTHING', [
      {
        'name': 'Mavi T-Shirt',
        'image': 'images/wear/mavi_tshirt.png',
        'price': 40,
        'desc':
        'I wore this tshirt only 2 times and it is not fitting me anymore.'
      },
      {
        'name': 'LTB Jean',
        'image': 'images/wear/ltb_jean.png',
        'price': 35,
        'desc':
        'I bought the wrong size and it is too big for me. We can deal with the point. Send me a message for more detail.'
      },
      {
        'name': 'GAP Sweatshirt',
        'image': 'images/wear/gap_sweatshirt.png',
        'price': 35,
        'desc':
        'I dont like the color od this anymore, you can come to my street to take it. Send me a message about condition.'
      },
    ], 'assets/images/clothing.png'),
    Category('HOME AND GARDENING', [
      {
        'name': 'Samsung Washing machine',
        'image': 'images/whitegoods/samsung_washing_machine.jpeg',
        'price': 4000,
        'desc':
        'We will buy a new washing machine so we want to give this to a student. It works fine.'
      },
      {
        'name': 'Beko Dishwasher',
        'image': 'images/whitegoods/beko_dishwasher.jpeg',
        'price': 3500,
        'desc':
        'We are moving from our house and we want to give it who needs a dishwaher. Send me a message about condition.'
      },

      {
        'name': 'Ikea Wardrobe',
        'image': 'images/whitegoods/ikea_wardrobe.jpeg',
        'price': 3500,
        'desc':
        'This wardrobe is too small for my all clothes, it is not useful for me anymore. It is in a very good condition. You can come and take it.'
      },
      {
        'name': 'Dinner Table',
        'image': 'images/whitegoods/dinner_table.jpeg',
        'price': 3500,
        'desc':
        'This dinner table is so good but it is too big for our new house! We want to give it because we will buy a new smaller one.'
      },

    ], 'assets/images/home_garden.png'),

    Category('FILM', [
      {
        'name': 'Seven DVD',
        'image': 'images/film/seven_dvd.jpeg',
        'price': 40,
        'desc':
        'This movie is the best!'
      },
      {
        'name': 'The Godfather DVD',
        'image': 'images/film/the_godfather_dvd.jpeg',
        'price': 35,
        'desc':
        'I dont need this DVD anymore because there is Netflix!'
      },
    ], 'assets/images/film.png'),

    Category('SPORTS', [
      {
        'name': 'Dumbell',
        'image': 'images/sport/dumbell.jpg',
        'price': 40,
        'desc':
        'I will go to gym for sport so i dont need this in my house anymore.'
      },
      {
        'name': 'Basketball Ball',
        'image': 'images/sport/basketball_ball.jpeg',
        'price': 35,
        'desc':
        'I broke my leg and doctor said that i can not play basketball anymore. Sadly, you can take it whenever you want.'
      },
      {
        'name': 'Football Ball',
        'image': 'images/sport/football_ball.jpeg',
        'price': 35,
        'desc':
        'I will buy a new one so I decided to give this who needs it.'
      },
      {
        'name': 'Bicycle',
        'image': 'images/sport/bicycle.jpeg',
        'price': 35,
        'desc':
        'I had an accident with my motorcycle and I can not use my bicycle. You can take it if you need it.'
      },
      {
        'name': 'Jump Rope',
        'image': 'images/sport/jump_rope.jpeg',
        'price': 35,
        'desc':
        'It is new. I never used this.'
      },

      {
        'name': 'Treadmill',
        'image': 'images/sport/treadmill.jpg',
        'price': 35,
        'desc':
        'It is too noisy for my apartment. You can take it.'
      },
    ], 'assets/images/sport.png'),
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
