import 'package:flutter/material.dart';

import 'package:treepy/app_styles.dart';
import 'package:treepy/views/Lecturer/report_pages/readingreportbar%20graph.dart';

import 'enrolledStudents.dart';


class reportsHomeNav extends StatefulWidget {
  final String Personatitle;
  final String Coursetitle;
  const reportsHomeNav({Key? key,  required this.Personatitle, required this.Coursetitle}) : super(key: key);

  @override
  State<reportsHomeNav> createState() => _reportsHomeNavState();
}

class _reportsHomeNavState extends State<reportsHomeNav> {

  late String Personatitle;
  late String Coursetitle;

  @override
  void initState() {
   Personatitle = widget.Personatitle;
   Coursetitle = widget.Coursetitle;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
        centerTitle: true,
      ),
      body: ListView(
        children:  [
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Enrolled Students'),
            trailing: MaterialButton(
                color: customBrown2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text('Open',
                  style: TextStyle(color: Colors.white),),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder:
                          (context) =>
                              EnrolledStudents(
                                  Coursetitle:Coursetitle,
                                  Personatitle:Personatitle))
                  );
                }

            ), ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Reading Reports'),
            trailing: MaterialButton(
            color: customBrown2,
            shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20)),    child: Text('Open',
    style: TextStyle(color: Colors.white),),
    onPressed: () {
    // Navigator.push(context,
    // MaterialPageRoute(builder:

    // (context) =>BarChartSample1()
    // )
    // );
    }

    ),
          )
        ],
      )

    );
  }
}