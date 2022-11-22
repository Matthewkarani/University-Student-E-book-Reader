//implement highlights
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:treepy/model/reading_report.dart';
import 'MakeNotes.dart';

class ReadingPage extends StatefulWidget {
  final String pdfUrl; //To open the pdf.
  //All the below will be used to set the reading report entries.
  final String personaTitle;
  final String topicTitle;
  final String notesTitle;

  const ReadingPage({
    Key? key,
    required this.pdfUrl, required this.personaTitle, required this.topicTitle, required this.notesTitle})
      : super(key: key);

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late String pdfUrl1;
  late String personaTitle;
  late String topicTitle;
  late String notesTitle;



  late DateTime startTime;//time when a person starts reading- used to caluculate the duration.
  @override
  void initState() {
    startTime = DateTime.now();
    pdfUrl1 = widget.pdfUrl;
    personaTitle= widget.personaTitle;
    topicTitle = widget.topicTitle;
    notesTitle = widget.notesTitle;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    String startingTime = DateFormat.Hms().format(startTime);
    print('Book start read time is $startingTime');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push((context),
              MaterialPageRoute(builder: (context) => const MakeNotesPage()
              ));
        },


        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            var leavingTime = DateTime.now();
            String closingTime = DateFormat.Hms().format(leavingTime);
            print('finishing time is $closingTime');
            DateTime dt1 = DateTime.parse('$leavingTime');
            DateTime dt2 = DateTime.parse('$startTime');
            Duration diff = dt1.difference(dt2);
            var finalDuration = diff.inSeconds ;
            //Turn the seconds to minutes

            print('Time taken to read the book is $diff');
            sendtoFirebase() {
              var auth = FirebaseAuth.instance;
              var uid = auth.currentUser?.uid;
              final readingReport = ReadingReport(
                  uid: uid,
                  readingStartTime: '$startTime',
                  readingEndTime: '$leavingTime',
                  notesTitle: notesTitle,
                  readingDuration: '$finalDuration seconds'

              );


              FirebaseFirestore.instance
                  .collection("users").doc(uid).
              collection("studentPersonas")
                  .doc(personaTitle)
                  .collection('Book_list')
                  .doc(notesTitle)//No of Books read
                  .collection('Reading_reports')//Total no of hours read
                  .doc('$leavingTime').set(readingReport.toFirestore());
            }
            sendtoFirebase();
            //Format the duration
            String _printDuration(Duration duration) {
              String twoDigits(int n) => n.toString().padLeft(2, "0");
              String twoDigitMinutes = twoDigits(
                  duration.inMinutes.remainder(60));
              String twoDigitSeconds = twoDigits(
                  duration.inSeconds.remainder(60));
              return "${twoDigits(
                  duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
            }

            _printDuration(diff);

            Navigator.pop(context);
            var minTime= 300 as Duration;
            if(diff < minTime!){
              ScaffoldMessenger.of(context).
              showSnackBar(SnackBar(content:
              Text('Come Back Soon')));
            }

          },
        ),
        centerTitle: true,
        title: Text(notesTitle),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(pdfUrl1,
        key: _pdfViewerKey,
      ),
    );
  }
}
