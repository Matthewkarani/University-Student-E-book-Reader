import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors{
  static Color bgColor = Color(0xFFe2eff);
  static final Color textColor = const Color(0xFFccc7c5);
  static final Color mainColor = const Color(0xFF89dad0);
  static Color accentColor = Color(0xFF0065FF);
  //static final Color mainColor = const Color(0xFFfa7552);
  static final Color iconColor1 = const Color(0xFFffd28d);
  static final Color iconColor2 = const Color(0xFFfcab88);
  static final Color paraColor = const Color(0xFF8f837f);
  static final Color buttonBackgroundColor= const Color(0xFFf7f6f4);
  static final Color signColor = const Color(0xFFa9a29f);
  static final Color titleColor = const Color(0xFF5c524f);
  static final Color mainBlackColor = const Color(0xFF332d2b);
  //static final Color yellowColor = const Color(0xFFfa7552);
  static final Color yellowColor = const Color(0xFFffd379);
  //Setting the notes cards in different colors
static List<Color> cardsColor = [
  Colors.white,
  Colors.red.shade100,
  Colors.pink.shade100,
  Colors.orange.shade100,
  Colors.yellow.shade100,
  Colors.green.shade100,
  Colors.blue.shade100,
  Colors.blueGrey.shade100,
];

//Setting the text style
 static TextStyle mainTitle = GoogleFonts.roboto(
   fontSize: 18.0,
   fontWeight: FontWeight.bold
 );

  static TextStyle mainContent = GoogleFonts.nunito(
      fontSize: 16.0,
      fontWeight: FontWeight.normal
  );



}