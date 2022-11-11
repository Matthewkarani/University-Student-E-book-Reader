import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treepy/app_styles.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:treepy/views/Student/Materials/Scheduler/reading_schedule%20home.dart';

import '../../../../api/notification _api.dart';
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
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then(
          (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Allow Notifications'),
              content: Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
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
                  builder: (_) => PlantStatsPage(),
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
