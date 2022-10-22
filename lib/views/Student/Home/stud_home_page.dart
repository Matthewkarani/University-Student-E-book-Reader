import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudHome extends StatefulWidget {
  const StudHome({Key? key}) : super(key: key);

  @override
  State<StudHome> createState() => _StudHomeState();
}

class _StudHomeState extends State<StudHome> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        leading: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            child: GestureDetector(
              child: Icon(Icons.import_contacts_outlined,
              color: Colors.white,),
            )

          ,),),
        title:Text('TREEPY',
          style: TextStyle(color: Colors.white),),
        centerTitle: true,
        
      )
    );

  }
}
