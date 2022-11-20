import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:treepy/app_styles.dart';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

class NotificationWeekAndTime {
  final int dayOfTheWeek;
  final TimeOfDay timeOfDay;

  NotificationWeekAndTime({
    required this.dayOfTheWeek,
    required this.timeOfDay,
  });

  factory NotificationWeekAndTime.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return NotificationWeekAndTime(
    dayOfTheWeek: data?['dayOfTheWeek'],
      timeOfDay: data?['timeOfDay'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (dayOfTheWeek != null) "dayOfTheWeek": dayOfTheWeek,
      if (timeOfDay != null) "timeOfDay": timeOfDay,



    };
  }
}


Future<NotificationWeekAndTime?> pickSchedule(
    BuildContext context,
    ) async {
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

  if (selectedDay != null) {
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



      if (timeOfDay != null) {
         int? dayofweek = selectedDay;
        // //parseDate Time
        // var datenow = DateTime.now();
        // var date = '$datenow';
        // DateTime parseDate =
        // new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
        // var inputDate = DateTime.parse(parseDate.toString());
        // var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
        // var outputDate = outputFormat.format(inputDate);

      var notificationDetails = <String, dynamic>{
        //'Schedule Title' : Scheduletitle,
        'selectedDay': weekdays[dayofweek! - 1],
        'timeOfDay': '$timeOfDay',
        'period' : timeOfDay.period.toString(),
         'created at' : DateTime.now()
      };

      FirebaseFirestore.instance.collection("Notifications").doc().set(
          notificationDetails);
      print('$notificationDetails');
      return NotificationWeekAndTime(
          dayOfTheWeek: selectedDay!, timeOfDay: timeOfDay);
     }
    }
    return null;
  }

