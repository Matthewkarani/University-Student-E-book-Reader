import 'package:flutter/material.dart';

class CreateReadingSchedule extends StatefulWidget {
  const CreateReadingSchedule({Key? key}) : super(key: key);

  @override
  State<CreateReadingSchedule> createState() => _CreateReadingScheduleState();
}

class _CreateReadingScheduleState extends State<CreateReadingSchedule> {

  final _formKey = GlobalKey<FormState>();
  late final String notes_description;

  final _readingScheduletitleController = TextEditingController();

  @override
  void dispose() {
    _readingScheduletitleController.dispose();
    super.dispose();
  }


  Widget buildTitle(){
    return Row(
      children: [
        Text('Schedule Title :', style:
        TextStyle(fontSize: 20),),
        SizedBox(width: 10,),
        Form(
          key: _formKey ,
          child: TextField(
            controller: _readingScheduletitleController ,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
label: Text('Set Reminder'), onPressed: () {  },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Create Reading Schedule'),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          buildTitle()
        ],
      ),
    );
  }
}
