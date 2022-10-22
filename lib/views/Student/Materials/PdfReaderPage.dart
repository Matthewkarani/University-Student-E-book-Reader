//implement highlights
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:treepy/app_styles.dart';

import 'MakeNotes.dart';

class ReadingPage extends StatefulWidget {
  const ReadingPage({Key? key}) : super(key: key);

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  bool _isLoading = true;
  late PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromAsset('assets/sample.pdf');

    setState(() => _isLoading = false);
  }

  changePDF(value) async {
    setState(() => _isLoading = true);
    if (value == 1) {
      document = await PDFDocument.fromAsset('assets/sample2.pdf');
    } else if (value == 2) {
      document = await PDFDocument.fromURL(
        "https://unec.edu.az/application/uploads/2014/12/pdf-sample.pdf",
        /* cacheManager: CacheManager(
          Config(
            "customCacheKey",
            stalePeriod: const Duration(days: 2),
            maxNrOfCacheObjects: 10,
          ),
        ), */
      );
    } else {
      document = await PDFDocument.fromAsset('assets/sample.pdf');
    }
    setState(() => _isLoading = false);
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer : Drawer(
        backgroundColor:  customBrown2,
        child : Column(
            children: [
            SizedBox(height: 36,),
            //ListTile WID
            ListTile(
              title: Text('Load from Assets',
                style: TextStyle(color: Colors.white),),
              onTap: () {
                changePDF(1);
              },
            ),
            ListTile(
              title: Text('Load from URL',
                style: TextStyle(color: Colors.white),),
              onTap: () {
                changePDF(2);
              },
            ),
            ListTile(
              title: Text('Restore default',
                style: TextStyle(color: Colors.white),),
              onTap: () {
                changePDF(3);
              },
            )

            //Text

          ]
        )
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('pdf reader page',
        //Implement PDF Reader Here
      )
        ),
      body: Stack(
        children: [

SizedBox(height:30),

Align(
  alignment: Alignment.bottomRight,
  child:   Padding(
    padding: const EdgeInsets.all(25.0),
    child: FloatingActionButton(
      onPressed: () {
        Navigator.push((context),
            MaterialPageRoute(builder: (context) => const MakeNotesPage()
            ));
      },

      child: Icon(Icons.add),



    ),
  ),
)
        ],
      ),
    );
  }
}
