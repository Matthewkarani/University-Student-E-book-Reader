//ReadingTime Calculator
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ReadingReport{
  late final String? uid;//Students uid
  late final String? readingEndTime;//This is the timestamp of the when the person
  late final String? readingStartTime;                                  //finishes reading. It is used to order firebase collection docs.
  final String? notesTitle;
  late final String? readingDuration;


  ReadingReport({
    this.uid,
    this.readingEndTime,
    this.notesTitle,
    this.readingStartTime,
    this.readingDuration
});

  // // DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  // //
  // // String string = dateFormat.format(DateTime.now()); //Con
  // calculateReadingTime(String start,String end){
  //   DateTime dt1 = DateTime.parse('$endTime');
  //   DateTime dt2 = DateTime.parse('$startTime');
  //
  //   Duration diff = dt1.difference(dt2);
  //   print(diff.inSeconds);
  //   //Then convert the seconds to hh:mm format
  //


// To create a new Duration object, use this class's
// single constructor
// giving the appropriate arguments:
  //const ReadingTime = Duration(hours: 2. minutes: 3, seconds:2);
  //}
//Function to read data
  factory ReadingReport.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      ReadingReport? options,
      ) {
    final data = snapshot.data();
    return ReadingReport(
      uid : data?['uid'],
      readingStartTime : data?['readingStartTime'],
      readingEndTime : data?['readingEndTime'],
      notesTitle : data?['notesTitle'],
      readingDuration : data?['readingDuration'],


    );
  }



  //Function to send data to the firestore
  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (readingStartTime != null) "readingStartTime": readingStartTime,
      if (readingEndTime != null) "readingEndTime": readingEndTime,
      if (notesTitle != null) "notesTitle": notesTitle,
      if (readingDuration != null) "readingDuration": readingDuration
    };
  }
}