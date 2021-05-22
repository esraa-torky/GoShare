import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_share/core/util/init/helper/size_config.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final Function search;
  const SearchWidget({
    Key key,
    @required this.searchController,
    @required this.search,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        textAlign: TextAlign.center,
        controller: searchController,
        style: TextStyle(fontSize: SizeConfig.text * 2),
        onChanged: (String value) => search(value),
        decoration: InputDecoration(
            border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: Colors.white, width: 0.0)),
            hintText: 'Search...'),
        autofocus: false,
      ),
    );
  }
}
