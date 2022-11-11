import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:treepy/app_styles.dart';
import 'package:treepy/views/Student/Materials/Scheduler/reading_schedule%20home.dart';
import 'package:treepy/views/Student/Materials/Scheduler/review_schedule_home.dart';

class scheduler_home extends StatefulWidget {
  const scheduler_home({Key? key}) : super(key: key);

  @override
  State<scheduler_home> createState() => _scheduler_homeState();
}

class _scheduler_homeState extends State<scheduler_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.book_rounded)),
                Tab(icon: Icon(Icons.book_outlined)),

              ],
            ),
            title: const Text('Scheduler'),
          ),
          body: TabBarView(
            children: [
              PlantStatsPage(),
              review_sch_home(),


            ],
          ),
        ),
      ),
    );
  }
}