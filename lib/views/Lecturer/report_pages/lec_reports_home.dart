import 'package:flutter/material.dart';

class LecReport extends StatefulWidget {
  const LecReport({Key? key}) : super(key: key);

  @override
  State<LecReport> createState() => _LecReportState();
}

class _LecReportState extends State<LecReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center
            (child: Text('Reports'))),
    );
  }
}
