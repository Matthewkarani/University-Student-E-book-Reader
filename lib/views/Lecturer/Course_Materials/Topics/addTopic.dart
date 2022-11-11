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
  final String Coursetitle;
  final String Personatitle;
  const addTopic({Key? key,required this.Coursetitle, required this.Personatitle}) : super(key: key);

  @override
  State<addTopic> createState() => _addTopicState();
}
class _addTopicState extends State<addTopic> {


  late Future _data;
  late String Coursetitle;
  late String Personatitle;
  final auth = FirebaseAuth.instance;

  void initState(){
    super.initState();
    Personatitle= widget.Personatitle;;
    Coursetitle = widget.Coursetitle;
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


  test() async{

  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [

        ],
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

                  //Topic Title Description

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
                      onPressed: ()=> {
                      savetofirebase(),

                      //  SavePersonaDetails(_courseTitleController.text.toString(),
                      //  _personaDescriptionController.text.trim()),


                      Navigator.pop(context)

                    }),

                ],
              ),
            ),
          )
      ),
    );
  }

/*Everytime a new topic is added, add it to the lecturers persona Topic, then
  Then duplicate it in all the enrolled students Topic collections for the
   respective personas*/


  Future savetofirebase() async {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    var authi = FirebaseAuth.instance;
    var db = FirebaseFirestore.instance;

    topic_title = _topicTitleController.text.trim();
    topic_description = _topicDescriptionController.text.trim();


    final topic = Topic(

      topic_title: topic_title,
      topic_Description: topic_description,
      isTopic: true,
      videoslinks: [],
      notesLinks: []
    );

    //Add topic to lecturer Topics collection for the respective persona.
    final docRef = FirebaseFirestore.instance
        .collection('Topics')
            .doc(Coursetitle).
        collection('My_Topics')
        .withConverter(
      fromFirestore: Topic.fromFirestore,
      toFirestore: (Topic topic, options) => topic.toFirestore(),
    )
        .doc(topic_title);
    await docRef.set(topic);


    /*Duplicate topic to the student topic collection for all the enrolled students
    of the particular persona.
    Step 1 Querry the studentsPersona collection find the specific persona Document
           and create a personaTopics subCollection. then add the topic.
           ... Use a collection group query *//*

    db.collectionGroup("studentsPersonas")
        .where("Persona_title", isEqualTo:title)
        .get().then((QuerySnapshot s) => s.docs.forEach((e) {
          print(e.id);

    })); not necessary*/


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

