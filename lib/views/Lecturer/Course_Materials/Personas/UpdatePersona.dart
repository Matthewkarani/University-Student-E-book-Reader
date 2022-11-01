import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app_styles.dart';
import '../../../../model/persona_model.dart';
import 'lec_persona_list.dart';

class UpdatePerona extends StatefulWidget {
  late String title;
  UpdatePerona({Key? key, required this.title}) : super(key: key);

  @override
  State<UpdatePerona> createState() => _UpdatePeronaState();
}

class _UpdatePeronaState extends State<UpdatePerona> {


  late Future _data;
  late String title;
  final auth = FirebaseAuth.instance;

  User? user = FirebaseAuth.instance.currentUser;

  final personaTitleController = TextEditingController();
  final _courseTitleController = TextEditingController();
  final _personaDescriptionController = TextEditingController();
  final _personaKeyController = TextEditingController();

  final _editpersonaTitleController = TextEditingController();
  final _editcourseTitleController = TextEditingController();
  final _editpersonaDescriptionController = TextEditingController();
  final _editpersonaKeyController = TextEditingController();

  @override
  void initState() {
    title = widget.title;
    super.initState();
  }
  final _formKey = GlobalKey<FormState>();

  late final String persona_title;
  late final String course_title;
  late final String persona_description;
  late final String persona_key;

  late final String editpersona_title;
  late final String editcourse_title;
  late final String editpersona_description;
  late final String editpersona_key;

  @override
  void dispose() {
    personaTitleController.dispose();
    _courseTitleController.dispose();
    _personaDescriptionController.dispose();
    _personaKeyController.dispose();
    _editpersonaTitleController.dispose();
    _editcourseTitleController.dispose();
    _editpersonaDescriptionController.dispose();
    _editpersonaKeyController.dispose();

    super.dispose();
  }




  editPesonaTitleDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: const Text('Edit Persona Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[


                new  TextField(

                  controller: _editpersonaTitleController,
                )

              ],
            ),
          ),
          actions: <Widget>[

            new TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  new TextField();
                });

              },
            ),

            SizedBox(height: 10,),

            TextButton(
                child: const Text('Save'),
                onPressed: () {
                  saveNewPersonaTitle();
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                      msg: "Persona Title Updated successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );


                }
            )
          ],
        );
      },
    );
  }
  editCourseTitleDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const  Text('Edit Course Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[

                new TextField(
                  controller: _editcourseTitleController,
                )

              ],
            ),
          ),
          actions: <Widget>[

            TextButton(
              child: const Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            SizedBox(height: 10,),

            TextButton(
                child: const Text('Save'),
                onPressed: () {
                  saveNewCourseTitle();
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                      msg: "Course Title Updated successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );

                }
            )
          ],
        );
      },
    );
  }
  editPersonaDescriptionDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('EditPersona Description'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[


                new TextField(
                  controller: _editpersonaDescriptionController,
                  maxLines: 7,
                )

              ],
            ),
          ),
          actions: <Widget>[

            TextButton(
              child: const Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            SizedBox(height: 10,),

            TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  saveNewPersonaDescription();
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                      msg: "Persona Descripton Updated successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );

                }
            )
          ],
        );
      },
    );
  }
  editPersonaKeyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Persona Key'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[

                new TextField(
                  controller: _editpersonaKeyController,
                )

              ],
            ),
          ),
          actions: <Widget>[

            TextButton(
              child: const Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            SizedBox(height: 10,),

            TextButton(
                child: const Text('Save'),
                onPressed: () {
                  saveNewPersonaKey();
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                      msg: "Persona Descripton Updated successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );

                }
            )
          ],
        );
      },
    );
  }


  Future saveNewPersonaTitle() async{

  }

  Future saveNewCourseTitle() async{

  }

  Future saveNewPersonaDescription() async{

  }

  Future saveNewPersonaKey() async{

  }









  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Persona Details'),
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
                final persona_Key = snapshot.data!['Persona_key'];


                return Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height:10,),

                        //Edit Persona Title
                        Text('Persona Title',style: TextStyle(fontSize: 22),),
                        SizedBox(height:5,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey),),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextField(
                                readOnly: true,
                                decoration:
                                InputDecoration(
                                    border: InputBorder.none,
                                    hintText: title),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),

                        MaterialButton(
                            color: customBrown2,
                            child: Text('Edit',style: TextStyle(color: Colors.white),),
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: (){
                              editPesonaTitleDialog();
                            }),

                        SizedBox(height: 20,),

                        //Edit Course Title
                        Text('Course Title',style: TextStyle(fontSize: 22),),
                        SizedBox(height:5,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey),),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextField(
                                readOnly: true,
                                controller: _courseTitleController,
                                decoration:
                                InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '$courseTitle'),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        MaterialButton(
                            color: customBrown2,
                            child: Text('Edit',style: TextStyle(color: Colors.white),),
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: (){
                              editCourseTitleDialog();
                            }),
                        SizedBox(height: 10,),

                        //Edit Persona Description
                        Text('Persona Description',style: TextStyle(fontSize: 22),),
                        SizedBox(height:5,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '$PersonaDescription',) ,
                                controller: _personaDescriptionController,
                                maxLines: 7,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),

                        MaterialButton(
                            color: customBrown2,
                            child: Text('Edit',style: TextStyle(color: Colors.white),),
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: (){
                              editPersonaDescriptionDialog();
                            }),
                        SizedBox(height: 10,),

                        //Persona Key
                        Text('Persona Key',style: TextStyle(fontSize: 22),),
                        SizedBox(height:5,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey),),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextField(
                                readOnly: true,
                                controller: _personaKeyController,
                                decoration:
                                InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '$persona_Key'),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        MaterialButton(
                            color: customBrown2,
                            child: Text('Edit',style: TextStyle(color: Colors.white),),
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: (){
                              editPersonaKeyDialog();
                            }),
                        SizedBox(height: 10,),


                      ],
                    ),
                  ),



                );
              }else
                return Container(
                  child: Center
                    (child: Text('Network Error')),
                );
            }
        )
    );
  }
}