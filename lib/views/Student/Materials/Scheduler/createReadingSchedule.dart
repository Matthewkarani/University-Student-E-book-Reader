import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treepy/app_styles.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:treepy/views/Student/Materials/Scheduler/reading_schedule%20home.dart';

import '../../../../api/notifications.dart';

import '../../../../util/utilities.dart';
import '../../../../widgets/big_text.dart';
import '../../../../widgets/my_text_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:treepy/app_styles.dart';

import 'Schedule_home.dart';


class CreateReadingSchedule extends StatefulWidget {
  const CreateReadingSchedule({Key? key}) : super(key: key);

  @override
  State<CreateReadingSchedule> createState() => _CreateReadingScheduleState();
}

class _CreateReadingScheduleState extends State<CreateReadingSchedule> {

  final _formKey = GlobalKey<FormState>();
  late final String notes_description;
  String? ScheduleTitle;

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
//Date Day Picker
  Widget PickDayTitle() =>  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: Align(alignment: Alignment.topLeft,
        child: BigText(text: 'Pick a Date',)),
  );

  Widget ChooseTimeTitle() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: Align(alignment: Alignment.topLeft,
        child: BigText(text: 'Pick a Time',)),
  );

  List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  TimeOfDay? timeOfDay;
  DateTime now = DateTime.now();
  int? selectedDay;
  late bool _dayIsSelected;
  late bool _timeIsSelected;

  @override
  void initState() {
    super.initState();
    _dayIsSelected = false;
    _timeIsSelected = false;
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

  Widget buildDayPicker() {
    int? dayofweek = selectedDay;

    return Row(
    children: [
      Form(
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child:  Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 35,
              width: 180,
              child: CupertinoTextField(
                placeholderStyle: TextStyle(color: Colors.black),
                placeholder: !_dayIsSelected ? "Choose a day " :  weekdays[dayofweek! - 1],
                readOnly: true,
                maxLines: 1,),
            ),
          )
          ,),),
      GestureDetector(
        onTap: () async{
          await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    'I want to be reminded every:',
                    textAlign: TextAlign.center,
                  ),
                  content: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 3,
                    children: [
                      for (int index = 0; index < weekdays.length; index++)
                        ElevatedButton(
                          onPressed: () {
                            selectedDay = index + 1;
                            setState(() {

                              _dayIsSelected = !_dayIsSelected;
                            });
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              customBrown2,
                            ),
                          ),
                          child: Text(weekdays[index]),
                        ),
                    ],
                  ),
                );
              });

        },
        child: Icon(Icons.edit_calendar,
          size: 35,
          color: customBrown2,),
      )

    ],
  );


  }


  Widget buildTimePicker() =>  Row(
    children: [
      Form(
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child:  Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 35,
              width: 180,
              child: CupertinoTextField(
                placeholderStyle: TextStyle(color: Colors.black),
                placeholder: !_timeIsSelected ? 'Choose a time' :
                '${timeOfDay!.hour} : ${timeOfDay!.minute}',
                readOnly: true,
                maxLines: 1,),
            ),
          )
          ,),),
      GestureDetector(
        onTap: () async{
          timeOfDay = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(
                now.add(
                  Duration(minutes: 1),
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData(
                    colorScheme: ColorScheme.light(
                      primary: customBrown2,
                    ),
                  ),
                  child: child!,
                );
              });
          setState(() {
            _timeIsSelected = !_timeIsSelected;
          });


        },
        child: Icon(Icons.access_time_outlined,
          size: 35,
          color: customBrown2,),
      )

    ],
  );
  Future<NotificationWeekAndTime?> pickSchedule(
      BuildContext context,
      ) async {

    //A function can have a return type or not.

  return NotificationWeekAndTime(
        dayOfTheWeek: selectedDay!,
        timeOfDay: timeOfDay!);

  }
  //take a break and try again later
  // @override
  // String formatTimeOfDay(TimeOfDay timeOfDay, {
  // var localizations = MaterialLocalizations.of(context);
  // final formattedTimeOfDay = localizations.formatTimeOfDay(timeOfDay);
  //   return '$buffer';
  // }

  //Reading reminder methods
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//       floatingActionButton: FloatingActionButton.extended(
// label: Text('Set Reminder'), onPressed: () {
//   Navigator.pop(context);
//       },
//       ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Create Schedule'),
        actions: [

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 10,),
            buildTitle(),
            SizedBox(height: 10,),
            buildForm(),
            //buildTitle(),
            SizedBox(height: 10,),
            PickDayTitle(),
            // MaterialButton(
            //     height: 40,
            //     color: customBrown2,
            //     shape:RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20)),
            //     child: Text('Choose Day',style:
            //     TextStyle(color: Colors.white),) ,
            //     onPressed: ()async{
            //
            //       }
            //
            // ),
            SizedBox(height: 10,),
            buildDayPicker(),
            SizedBox(height: 10,),
            ChooseTimeTitle(),
            SizedBox(height: 10,),
            buildTimePicker(),
            SizedBox(height: 10,),

            MaterialButton(
                height: 40,
                color: customBrown2,
              shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
                child: Text('Create Reading Schedule',style:
                TextStyle(color: Colors.white),) ,
                onPressed: () async{
                  ScheduleTitle = _readingScheduletitleController.text.trim();
                  if(ScheduleTitle == null){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a Schedule Title')));
                  }
      int? dayofweek = selectedDay;

      var notificationDetails = <String, dynamic>{
        'Schedule Title' : ScheduleTitle,
        'selectedDay': weekdays[dayofweek! - 1],
        'timeOfDay': '${timeOfDay!.hour} : ${timeOfDay!.minute}',
        'created at' : DateTime.now()
      };

      FirebaseFirestore.instance.collection("Notifications").doc(ScheduleTitle).set(
          notificationDetails);
      print('$notificationDetails');

   //Reproduce the pickSchedule function
                  NotificationWeekAndTime? pickedSchedule =
                  await pickSchedule(context);

                  if (pickedSchedule != null) {
                    createScheduledReadingReminderNotification(pickedSchedule);
                  }
     Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context)=> scheduler_home(),
              ));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content : Text('Schedule Created Successfully')),
    );

                }

    )

          ],
        ),
      ),
    );
  }
}
