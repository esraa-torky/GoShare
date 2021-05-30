import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_share/core/util/init/helper/size_config.dart';

Container titleWidget(String title, Color fontColor, {String categoryName}) {
  return Container(
    alignment: Alignment.center,
    width: double.infinity,
    child: AutoSizeText(
      '$title${categoryName != null ? '  $categoryName' : ''}',
      maxLines: 2,
      minFontSize: 5,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: fontColor,
          fontSize: SizeConfig.text * 5,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans'),
    ),
  );
}
