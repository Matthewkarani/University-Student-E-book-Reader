import 'package:flutter/cupertino.dart';

//This is our reusable text widget
class SmallText extends StatelessWidget {
  final Color? color;//Means we will pass a color value.
  final String text;
  double size;
  double height;
  //Above 4 are properties and below the parameters.
  SmallText({Key? key,
    this.height = 1.2,
    this.color =  const Color(0xFF332d2b),
    this.size= 18,
    required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
      TextStyle(
          color: color,
          fontFamily: 'Roboto',
          fontSize: size,
          height : height
      )
    );
  }
}
