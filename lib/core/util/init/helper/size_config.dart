import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/*
SizeConfig file is a tool to adopt to different screen sizes.
It will take the origiginal design values and adopt to current 
screen size with multipliers. This will allow to keep the original 
design on every screen size including ipad amd tablet.
 */

class SizeConfig {
  static double _screenWidth;
  static double _screenHeight;
  static double _blockSizeHorizontal;
  static double _blockSizeVertical;

  static Orientation orientation;
  static bool isMobile;
  static double text;
  static double image;
  static double height;
  static double width;
  static double maxWidth;
  static double maxHeight;
  static bool isTablet;
  static bool isPhone;
  static double devicePixelRatio = ui.window.devicePixelRatio;

  void init(BoxConstraints constraints, Orientation _orientation) {
    orientation = _orientation;
    _screenWidth = constraints.maxWidth;
    _screenHeight = constraints.maxHeight;
    maxWidth = constraints.maxWidth;
    maxHeight = constraints.maxHeight;
    isMobile = constraints.biggest.shortestSide < 600;

    _blockSizeHorizontal = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;

    text = _blockSizeVertical;
    image = _blockSizeHorizontal;
    height = _blockSizeVertical;
    width = _blockSizeHorizontal;

    if (devicePixelRatio < 2 && (width >= 1000 || height >= 1000)) {
      isMobile = false;
    } else if (devicePixelRatio == 2 && (width >= 1920 || height >= 1920)) {
      isMobile = false;
    } else {
      isMobile = true;
    }

    // Recalculate for Android Tablet using device inches
    if (Platform.isAndroid) {
      final adjustedWidth = _calWidth() / devicePixelRatio;
      final adjustedHeight = _calHeight() / devicePixelRatio;
      final diagonalSizeInches = (math
              .sqrt(math.pow(adjustedWidth, 2) + math.pow(adjustedHeight, 2))) /
          _ppi;

      if (diagonalSizeInches >= 7) {
        isMobile = false;
      } else {
        isMobile = true;
      }
    }

  }

  static double _calWidth() {
    var _width = ui.window.physicalSize.width;
    var _height = ui.window.physicalSize.height;
    if (_width > _height) {
      return (_width +
          (ui.window.viewPadding.left + ui.window.viewPadding.right) *
              (_width) /
              _height);
    }
    return (_width + ui.window.viewPadding.left + ui.window.viewPadding.right);
  }

  static double _calHeight() {
    var _height = ui.window.physicalSize.height;

    return (_height +
        (ui.window.viewPadding.top + ui.window.viewPadding.bottom));
  }

  static int get _ppi => Platform.isAndroid
      ? 160
      : Platform.isIOS
          ? 150
          : 96;
}
