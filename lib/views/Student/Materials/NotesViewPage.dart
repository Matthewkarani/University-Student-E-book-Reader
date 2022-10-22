import 'package:flutter/material.dart';

class MyNotesView extends StatefulWidget {
  const MyNotesView({Key? key}) : super(key: key);

  @override
  State<MyNotesView> createState() => _MyNotesViewState();
}

class _MyNotesViewState extends State<MyNotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes List'),
      ),
    );
  }
}
