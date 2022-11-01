import 'package:flutter/material.dart';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:treepy/model/persona_model.dart';
import 'package:treepy/views/Lecturer/Course_Materials/Personas/lec_persona_list.dart';
import 'package:treepy/views/Lecturer/Course_Materials/Topics/topic_list_page.dart';


import '../../../../app_styles.dart';
import '../../../../model/Topic_model.dart';
import '../Personas/Persona Materials.dart';

class addTopic extends StatefulWidget {
  final String title;
  const addTopic({Key? key,required this.title}) : super(key: key);

  @override
  State<addTopic> createState() => _addTopicState();
}
class _addTopicState extends State<addTopic> {


  late Future _data;
  late String title;
  final auth = FirebaseAuth.instance;

  void initState(){
    super.initState();
    title = widget.title;
  }


  final _topicTitleController = TextEditingController();
  final _topicDescriptionController = TextEditingController();



  final _formKey = GlobalKey<FormState>();

  late final String topic_title;
  late final String topic_description;


  @override
  void dispose() {

    _topicTitleController.dispose();
    _topicDescriptionController.dispose();


    super.dispose();
  }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Create New Topic',
          style:
          GoogleFonts.barlowCondensed(fontSize: 22),
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
                      child: Text('Topic Title',style:
                      GoogleFonts.openSans(fontSize: 24),),
                    ),
                  ),
                  SizedBox(height:10),
                  //Topic Title Edit Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child:  CupertinoTextField(

                      controller: _topicTitleController,
                      maxLines: 1,)
                    ,),
                  SizedBox(height:10),
                  //Topic Title Description
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text('Topic Description',style:
                      GoogleFonts.openSans(fontSize: 24),),
                    ),
                  ),
                  SizedBox(height:10),
                  //Topic Description Edit Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child:  CupertinoTextField(

                      controller: _topicDescriptionController,
                      maxLines: 5,)
                    ,),

                  SizedBox(height :10),

                  //Create Topic Button
                  CupertinoButton(
                      borderRadius: BorderRadius.circular(30),
                      color: customBrown,
                      child: Text('Create',style: TextStyle(color: Colors.white),),
                      onPressed: ()=>{
                        savetofirebase(),

                        //  SavePersonaDetails(_courseTitleController.text.toString(),
                        //  _personaDescriptionController.text.trim()),


                        Navigator.push (context,MaterialPageRoute(builder:
                            (context) =>  TopicsList(title: title,)
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



  Future savetofirebase() async {
    final User? user = auth.currentUser;
    final uid = user?.uid;

    topic_title = _topicTitleController.text.trim();
    topic_description = _topicDescriptionController.text.trim();


    final topic = Topic(

      topic_title: topic_title,
      topic_Description: topic_description,
      isTopic: true,
    );

    final docRef = FirebaseFirestore.instance
        .collection("Topics").doc(title).
    collection("My_Topics")
        .withConverter(
      fromFirestore: Topic.fromFirestore,
      toFirestore: (Topic topic, options) => topic.toFirestore(),
    )
        .doc(topic_title);
    await docRef.set(topic);

    Fluttertoast.showToast(
        msg: "Topic Created Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

