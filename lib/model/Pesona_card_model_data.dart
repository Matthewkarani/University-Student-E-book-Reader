 import 'package:flutter/material.dart';
//Base class for the persona
abstract class PersonaItem{
  //title line to show in a list
  Widget  buildPersonaTitle(BuildContext context);

  Widget buildCourseTitle(BuildContext context);



}
//A list Item that contains data to display a heading
class HeadingItem implements PersonaItem{
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildPersonaTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  @override
  Widget buildCourseTitle(BuildContext context) => const SizedBox.shrink();


}

//A list item that contains data to display a message
class PersonaCard implements PersonaItem{
  final String Author;
  final String PersonaTitle;

  PersonaCard(this.Author,this.PersonaTitle);




  @override
  Widget buildPersonaTitle(BuildContext context) => Text(Author);


  @override
  Widget buildCourseTitle(BuildContext context) => Text(PersonaTitle);
  }


  final items = List<PersonaItem>.generate(
  1000,
      (i) => i % 6 == 0
      ? HeadingItem('Heading $i')
      : PersonaCard('Sender $i', 'Message body $i'),
);
