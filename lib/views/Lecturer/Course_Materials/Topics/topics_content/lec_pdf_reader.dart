//implement highlights
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:treepy/app_styles.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';



class lecReadingPage extends StatefulWidget {
  final String pdfUrl;
  const lecReadingPage({Key? key,
    required this.pdfUrl}) : super(key: key);

  @override
  State<lecReadingPage> createState() => _lecReadingPageState();
}

class _lecReadingPageState extends State<lecReadingPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late String pdfUrl1;
  @override
  void initState() {
    pdfUrl1 = widget.pdfUrl;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },


        child: Icon(Icons.add),
      ) ,
      appBar: AppBar(
        centerTitle: true,
        title: Text('pdf reader page',),
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
      body:SfPdfViewer.network(pdfUrl1,
        key: _pdfViewerKey,
      ),
    );
  }
}