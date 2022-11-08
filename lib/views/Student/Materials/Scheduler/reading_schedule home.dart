import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'createReadingSchedule.dart';

class reading_sch_home extends StatefulWidget {
  const reading_sch_home({Key? key}) : super(key: key);

  @override
  State<reading_sch_home> createState() => _reading_sch_homeState();
}

class _reading_sch_homeState extends State<reading_sch_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
      FloatingActionButton(
        onPressed: (){
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: CreateReadingSchedule(),
            withNavBar: false, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );

        },
        child: Icon(Icons.add),),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Align(
              alignment:Alignment.topCenter,
              child: Text('My reading Schedules'
            ,style: TextStyle(
                  fontSize: 22,
                    decoration: TextDecoration.underline),)),
          SizedBox(height: 10,),


        ],
      ),
    );
  }
}

