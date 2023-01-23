import 'package:flutter/widgets.dart';


Orientation orientation(BuildContext context) =>
    MediaQuery.of(context).orientation;

Size screenSize(BuildContext context) => MediaQuery.of(context).size;

Size screenSizeSwappedDimensions(BuildContext context) =>
    screenSize(context).flipped;

double aspectRatio(BuildContext context) => screenSize(context).aspectRatio;

double screenWidth(BuildContext context) => screenSize(context).width;

double screenHeight(BuildContext context) => screenSize(context).height;

double screenLongestSide(BuildContext context) =>
    screenSize(context).longestSide;

double screenShortestSide(BuildContext context) =>
    screenSize(context).shortestSide;
