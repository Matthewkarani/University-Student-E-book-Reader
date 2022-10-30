import 'package:flutter/material.dart';

class UpdateTopic extends StatefulWidget {
  const UpdateTopic({Key? key}) : super(key: key);

  @override
  State<UpdateTopic> createState() => _UpdateTopicState();
}

class _UpdateTopicState extends State<UpdateTopic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Update Topic'),
      ),
    );
  }
}
