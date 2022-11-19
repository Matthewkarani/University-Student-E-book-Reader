import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treepy/app_styles.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:treepy/views/Student/Materials/Scheduler/reading_schedule%20home.dart';

import '../../../../api/notifications.dart';
import '../../../../widgets/big_text.dart';
import '../../../../widgets/my_text_button.dart';

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

  Widget buildTitle() =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Align(alignment: Alignment.topLeft,
            child: BigText(text: 'Add Schedule Title',)),
      );
  Widget buildForm() => Form(
    key:_formKey,
    child:  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child:  CupertinoTextField(


        controller: _readingScheduletitleController,
        maxLines: 1,)
      ,),

  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
label: Text('Set Reminder'), onPressed: () {  },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Create Reading Schedule'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReadingScheduleHome(),
                ),
              );
            },
            icon: Icon(
              Icons.insert_chart_outlined_rounded,
              size: 30,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          buildTitle(),
          SizedBox(height: 10,),
          buildForm(),
          //buildTitle(),
          SizedBox(height: 10,),
          ElevatedButton(
              onPressed: () {
                //   NotificationsApi.showNotification(
                //   title : 'Hey Engineer Matthew',
                //   body : 'It\'s time to read your book on '+
                //       ' intro to software Engineering',
                //   payload: 'Matthew.abs',
                // );},
                // child: Text('Simple Notification',
                // ))
              }, child: Text('Simple Notification')),

        ],
      ),
    );
  }
}
