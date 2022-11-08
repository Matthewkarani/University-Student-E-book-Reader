import 'package:flutter/cupertino.dart';

//This is our reusable text widget
class BigText extends StatelessWidget {
  final Color? color;//Means we will pass a color value.
  final String text;
  double size;
  TextOverflow overflow;//Above 4 are properties and below the parameters.
   BigText({Key? key,
    this.color = const Color(0xFF332d2b),
    this.size=20,
    this.overflow=TextOverflow.ellipsis,//If text size is longer than certain width , it will show the dots(...)
    required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style:
      TextStyle(
          color: color,
      fontFamily: 'Roboto',
      fontSize: size,
      fontWeight: FontWeight.w400),
    );
  }
}
