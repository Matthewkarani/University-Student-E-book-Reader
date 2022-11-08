import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class review_sch_home extends StatefulWidget {
  const review_sch_home({Key? key}) : super(key: key);

  @override
  State<review_sch_home> createState() => _review_sch_homeState();
}

class _review_sch_homeState extends State<review_sch_home> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
      FloatingActionButton(
        onPressed: (){},
       child: Icon(Icons.add),),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Align(
              alignment:Alignment.topCenter,
              child: Text('My review Schedules'
                ,style: TextStyle(
                    fontSize: 22,
                    decoration: TextDecoration.underline),)),
          SizedBox(height: 10,),

          //


        ],
      ),
    );
  }
}

