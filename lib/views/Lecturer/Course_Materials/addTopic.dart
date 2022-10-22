import 'package:flutter/material.dart';

class addTopic extends StatefulWidget {
  const addTopic({Key? key}) : super(key: key);

  @override
  State<addTopic> createState() => _addTopicState();
}

class _addTopicState extends State<addTopic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Topic'),
      ),
    );
  }
}
