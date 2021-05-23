import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_share/common/widgets/search_widget.dart';
import 'package:go_share/common/widgets/title_widget.dart';
import 'package:go_share/providers/home/home_provider.dart';
import 'package:go_share/views/home/layouts/category_list.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('GoShare', style: const TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold)), backgroundColor: Colors.deepPurple,
      ),
      body: Consumer<HomeProvider>(
        builder: (ctxHome, home, child) => SafeArea(
          child: Column(
            children: [
              titleWidget(home.title, Colors.deepPurple),
              SearchWidget(
                searchController: home.searchController,
                search: home.searchCategories,

              ),
              Expanded(
                  child: CategoryList(
                categories: home.filteredCategories,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
