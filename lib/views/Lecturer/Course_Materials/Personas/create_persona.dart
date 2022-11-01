import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:treepy/model/persona_model.dart';
import 'package:treepy/views/Lecturer/Course_Materials/Personas/lec_persona_list.dart';


import '../../../../app_styles.dart';
import 'Persona Materials.dart';

class createPersona extends StatefulWidget {
  const createPersona({Key? key}) : super(key: key);

  @override
  State<createPersona> createState() => _createPersonaState();
}

class _createPersonaState extends State<createPersona> {

  final _personaTitleController = TextEditingController();
  final _courseTitleController = TextEditingController();
  final _personaDescriptionController = TextEditingController();
  final _personaKeyController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

   late final String persona_title;
   late final String course_title;
   late final String persona_description;
   late final String persona_key;

  @override
  void dispose() {
    _personaTitleController.dispose();
    _courseTitleController.dispose();
    _personaDescriptionController.dispose();
    _personaKeyController.dispose();

    super.dispose();
  }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Create New Persona',
          style:
          GoogleFonts.barlowCondensed(fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child:SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
            children: [
              SizedBox(height:10),

                //Persona Title

                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text('Persona Title',style:
                    GoogleFonts.openSans(fontSize: 24),),
                  ),
                ),
              SizedBox(height:10),
              //Persona Title Edit Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child:  CupertinoTextField(

                  controller: _personaTitleController,
                  maxLines: 1,)
                ,),
              SizedBox(height:10),
              //Course Title
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text('Course Title',style:
                  GoogleFonts.openSans(fontSize: 24),),
                ),
              ),

              SizedBox(height:10),
              //course Title Edit Text
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child:  CupertinoTextField(
    controller: _courseTitleController,
    maxLines: 1,)
      ,),
              SizedBox(height:10),
                //Persona Description
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text('Persona Description',style:
                  GoogleFonts.openSans(fontSize: 24),),
                ),
              ),
              SizedBox(height: 10,),

              //persona Description Edit Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child:  CupertinoTextField(
                controller: _personaDescriptionController,
                maxLines: 7,

              ),
              ),

              //Persona Key

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text('Persona Key',style:
                  GoogleFonts.openSans(fontSize: 24),),
                ),
              ),

              SizedBox(height:10),
              //course Title Edit Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child:  CupertinoTextField(
                  controller: _personaKeyController,
                  maxLines: 1,)
                ,),
              SizedBox(height:10),

              //Create Persona Button
              CupertinoButton(
                borderRadius: BorderRadius.circular(30),
                  color: customBrown,
                  child: Text('Create',style: TextStyle(color: Colors.white),),
                  onPressed: ()=>{
                   savetofirebase(),

                  //  SavePersonaDetails(_courseTitleController.text.toString(),
                      //  _personaDescriptionController.text.trim()),


                   Navigator.push (context,MaterialPageRoute(builder:
                  (context) => const mypersonas()
                   )
                   ) }
              ),


                                SizedBox(height: 25,),

                              ],
                              ),
                            ),
                          )
                        ),
                      );
                    }

                    final FirebaseAuth auth = FirebaseAuth.instance;

                    Future savetofirebase() async {
                      final User? user = auth.currentUser;
                      final uid = user?.uid;
                      String? lecFirstName;
                      String? lecLastName;


                      persona_title = _personaTitleController.text.trim();
                      course_title =  _courseTitleController.text.trim();
                      persona_description = _personaDescriptionController.text.trim();
                      persona_key= _personaKeyController.text.trim();

                      final persona = Persona(
                      Persona_title:persona_title ,
                      Course_Title: course_title,
                      Persona_Description: persona_description,
                      Persona_key:persona_key ,
                      IsPersona: true,
                          lecId: auth.currentUser?.uid,
                          personaID: persona_title
                      );


                     FirebaseFirestore.instance.collection('users').doc(uid).get().then((s) =>
                     lecFirstName = s.data()!['first name'],
                     );


                     var lecDetails = <String,dynamic>{
                        'uid' : uid,
                        'isLec' : true,
                        'first name': lecFirstName,

                      };

                      FirebaseFirestore.instance.collection("Persona").doc(uid).set(lecDetails);



                      //do a read of the data base, where the uid field mateches the lecs uid
                      //get the document id.


                      FirebaseFirestore.instance
                          .collection("Persona").doc(uid).
                      collection("my_personas")
                          .withConverter(
                        fromFirestore: Persona.fromFirestore,
                        toFirestore: (Persona persona, options) => persona.toFirestore(),)
                          .doc(persona_title).set(persona);



                      //create persona subcollection



                      Fluttertoast.showToast(
                          msg: "Persona Created Successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                  }
                  }

//Future SavePersonaDetails(String CourseTitle, String PersonaDesciption) async {
  //await FirebaseFirestore.instance.collection('Personas').doc().collection('Persona Details').doc().set({
    //'Course Title': CourseTitle,
    //'Persona Description': PersonaDesciption,
  //});
//}

//Future   SavetoPersonaTitle(String Author,) async{
  //await FirebaseFirestore.instance.collection('Personas').doc(uid).set({
    //'Lecturer Name': Author,
 // });

//}



//Have the persona title as the only field in the collection so that when you are
//filling data to the

//I Need eacH LECTURER TO HAVE ONe main persona 'Folder'...Within that folder,all
//the personas that they will ever create will be stored as sub collections of the
//main persona folder.
//THE main persona folder should have the lecturers uid as the doc id
//I need each new persona to be a subcollection of the Main Persona Collection.
//Each persona
//Then eac