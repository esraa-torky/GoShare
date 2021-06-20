import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_share/ContactUs.dart';
import 'package:go_share/common/widgets/search_widget.dart';
import 'package:go_share/common/widgets/title_widget.dart';
import 'package:go_share/providers/home/home_provider.dart';
//import 'package:go_share/views/home/layouts/category_list.dart';
import 'package:provider/provider.dart';

import '../../UserProfile.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('GoShare', style: const TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold)), backgroundColor: Color(0xff669966),
      ),
     drawer: Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Color(0xffffcc00),
          ),
          child: Text('MENU'),
        ),
        ListTile(
          title: Text('User Profile'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return UserProfile();
                },
              ),
            );
          },
        ),
        ListTile(
          title: Text('Settings'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Maps'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Contact Us'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ContactUsPage();
                },
              ),
            );
          },
        ),
      ],
    ),

    ),
      body: Consumer<HomeProvider>(
        builder: (ctxHome, home, child) => SafeArea(
          child: Column(
            children: [
              titleWidget(home.title, Color(0xff669966)),
              SearchWidget(
                searchController: home.searchController,
                search: home.searchCategories,

              ),
              // Expanded(
              //     child: CategoryList(
              //   categories: home.filteredCategories,
              // )),
            ],
          ),
        ),
      ),
    );
  }
}
