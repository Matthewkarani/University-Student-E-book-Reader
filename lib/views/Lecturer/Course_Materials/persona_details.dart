import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/persona_model.dart';

class personaDetails extends StatefulWidget {
 const personaDetails({Key? key}) : super(key: key);

  //Our detail page can now receive a persona detail object which is of the type
  //Documentsnapshot as a parameter
   //personaDetails({required this.PDetails});


  @override
  State<personaDetails> createState() => _personaDetailsState();
}

class _personaDetailsState extends State<personaDetails> {
  //we then use the Details object inside the _personaDetails state


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.brown,),
        title: Text('Persona Title', style:
        TextStyle(color: Colors.black),),
        //widget.PDetails.data()!["Persona_title"] ,style:
        //         TextStyle(color: Colors.black
        //         ),
      ),
      body: SafeArea(
        child: Container(
          child: Card(
            child: ListTile(
            title: Text('Course Title'),
              //widget.PDetails.data()!["Course_Title"]
              subtitle: Text('Persona Description'),
               // widget.PDetails.data()!["Persona_Description"]
          ),
        )
      )


          //Below is the structure of the persona description page
          /*child: Column(
            children: [
              SizedBox(height: 15,),
              //Persona Title
              Text('data'),

              //Course Title
              Text('data'),


              //Persona Description
              Text('data'),



              //Add Topic Button


              //


            ],
          ),*/
        ),
      );





  }
}
