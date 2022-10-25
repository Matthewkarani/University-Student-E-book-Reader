import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/persona_model.dart';
import '../../auth/auth_helper.dart';

class personaDetails extends StatefulWidget {
  final String title;
 const personaDetails({Key? key, required this.title}) : super(key: key);

  //Our detail page can now receive a persona detail object which is of the type
  //Documentsnapshot as a parameter
   //personaDetails({required this.PDetails});


  @override
  State<personaDetails> createState() => _personaDetailsState();
}

class _personaDetailsState extends State<personaDetails> {
  //we then use the Details object inside the _personaDetails state

  late Future _data;
  late String title;
  final auth = FirebaseAuth.instance;




  void initState(){
    super.initState();
    title = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.brown,),
        title: Text(title, style:
        TextStyle(color: Colors.black),),
        //widget.PDetails.data()!["Persona_title"] ,style:
        //         TextStyle(color: Colors.black
        //         ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
    stream : FirebaseFirestore.instance.collection("Persona")
        .doc(auth.currentUser!.uid)
        .collection('my_personas').doc(title).snapshots(),
    builder: (BuildContext context ,
    AsyncSnapshot<DocumentSnapshot> snapshot){
    if(snapshot.hasData && snapshot.data != null){
    // get the value of the role field
    final courseTitle = snapshot.data!['Course_Title'];
    final PersonaDescription = snapshot.data!['Persona_Description'];

    return Container(
    child: Card(child:
    ListTile(
    title: Text(courseTitle),
    subtitle: Text(PersonaDescription),
    ),));
    }
    return Container();
    })
    );
  }
}


