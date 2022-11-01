import 'package:flutter/material.dart';

class CreateReadingSchedule extends StatefulWidget {
  const CreateReadingSchedule({Key? key}) : super(key: key);

  @override
  State<CreateReadingSchedule> createState() => _CreateReadingScheduleState();
}

class _CreateReadingScheduleState extends State<CreateReadingSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Create Reading Schedule'),
      ),
    );
  }
}
