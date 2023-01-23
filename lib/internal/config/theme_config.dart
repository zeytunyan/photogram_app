import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

const Color snow = Color.fromARGB(255, 255, 250, 250);
const Color royalBlue = Color.fromARGB(255, 70, 130, 180);

final MaterialColor primarySwatch = createMaterialColor(royalBlue);
final MaterialColor canvasColor = createMaterialColor(snow);

const mainFont = GoogleFonts.sarabun;
const logoFont = GoogleFonts.norican;

const royalBlueStatusBar = SystemUiOverlayStyle(
  statusBarColor: royalBlue,
  statusBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.light,
);

const snowStatusBar = SystemUiOverlayStyle(
  statusBarColor: snow,
  statusBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.dark,
);

MaterialColor createMaterialColor(Color color) {
  final int r = color.red, g = color.green, b = color.blue;
  final strengths = [.05, for (int i = 1; i < 10; i++) 0.1 * i];
  int rgbShade(int c, double ds) => c + (ds < 0 ? c : (255 - c)) * ds.round();
  Map<int, Color> swatch = {};

  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      rgbShade(r, ds),
      rgbShade(g, ds),
      rgbShade(b, ds),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
