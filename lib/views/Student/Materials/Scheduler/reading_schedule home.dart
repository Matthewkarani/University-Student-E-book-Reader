
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '../../../../api/notifications.dart';
import '../../../../util/utilities.dart';
import '../../../../widgets/widgets.dart';
import 'createReadingSchedule.dart';

class ReadingScheduleHome extends StatefulWidget {
  const ReadingScheduleHome({Key? key}) : super(key: key);

  @override
  State<ReadingScheduleHome> createState() => _ReadingScheduleHome();
}

class _ReadingScheduleHome extends State<ReadingScheduleHome> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then(
          (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
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
                      onPressed: () =>
                          AwesomeNotifications()
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('My reading schedules'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>
                CreateReadingSchedule())
        ); },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Plant Stats',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 45,
              ),
              SizedBox(
                  height:10 ,
                  child: PlantImage()),
              SizedBox(
                height: 25,
              ),
              HomePageButtons(
                onPressedOne: () async {
                  createReadingReminderNotification();
                },
                onPressedTwo: () async {
                  NotificationWeekAndTime? pickedSchedule =
                  await pickSchedule(context);

                  if (pickedSchedule != null) {
                    createWaterReminderNotification(pickedSchedule);
                  }
                },
                onPressedThree:cancelScheduledNotifications,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


