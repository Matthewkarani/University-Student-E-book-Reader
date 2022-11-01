import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MakeNotesPage extends StatefulWidget {
  const MakeNotesPage({Key? key}) : super(key: key);

  @override
  State<MakeNotesPage> createState() => _MakeNotesPageState();
}

class _MakeNotesPageState extends State<MakeNotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make Notes Page'),
      ),
    );
  }
}


