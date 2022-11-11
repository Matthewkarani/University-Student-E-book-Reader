import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../Home/Home_lec.dart';

class PersonaDeleted extends StatefulWidget {
  final String Personatitle;
  const PersonaDeleted({Key? key, required this.Personatitle}) : super(key: key);

  @override
  State<PersonaDeleted> createState() => _PersonaDeletedState();
}

class _PersonaDeletedState extends State<PersonaDeleted> {

  late String Personatitle;
  @override
  void initState() {
    Personatitle = widget.Personatitle;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          //Centered text saying deletion successful.
          Text('The ' + Personatitle + ' has been deleted successfully'),
          SizedBox(height: 10,),

          //Button to push user to the home screen
          ElevatedButton(
              onPressed: (){



              }
              , child: Text('To home'))
        ],
      )
    );
  }
}
