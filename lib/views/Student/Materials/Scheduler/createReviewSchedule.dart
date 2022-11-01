//duplicate Reading Scedule
import 'package:flutter/material.dart';

class Review_Schedule extends StatefulWidget {
  const Review_Schedule({Key? key}) : super(key: key);

  @override
  State<Review_Schedule> createState() => _Review_ScheduleState();
}

class _Review_ScheduleState extends State<Review_Schedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text('Create Review Schedule')
      ),
    );
  }
}

