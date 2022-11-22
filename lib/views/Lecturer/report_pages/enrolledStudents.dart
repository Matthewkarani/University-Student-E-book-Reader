import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treepy/app_styles.dart';
import 'package:treepy/views/Lecturer/Course_Materials/Topics/topics_content/lec_topic_content_page.dart';

import '../Course_Materials/Topics/addTopic.dart';



class EnrolledStudents extends StatefulWidget {
  final String Coursetitle;
  final String Personatitle;
  const EnrolledStudents({Key? key, required this.Coursetitle, required this.Personatitle}) : super(key: key);

  @override
  State<EnrolledStudents> createState() => _EnrolledStudents();
}

class _EnrolledStudents extends State<EnrolledStudents> {

  //VoidCallback void() is a function which takes no parameters
  // and returns no parameters.
  // In Flutter it is also true.
  // Sometimes we call it simply callback.
  late String Coursetitle;
  late String Personatitle;
  late Future _data;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    Coursetitle = widget.Coursetitle;
    Personatitle = widget.Personatitle;
    super.initState();
  }




  Future getEnrolledStudents() async {
    var Firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await Firestore
        .collection('Persona')
        .doc(auth.currentUser?.uid)
        .collection('my_personas')
        .doc(Personatitle)
        .collection('enrolled_students')
        .get();

    return qn.docs;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add, semanticLabel: 'Add Topic'),
        //   onPressed: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(
        //             builder: (context) => addTopic(Coursetitle: Coursetitle, Personatitle: '',)));
        //   },
        // ),--> Consider adding a functionality where a lecturer can enroll a student.
        appBar: AppBar(
          actions: [
           // Icon(Icons.more_horiz)
          ],
          leading: BackButton(),
          title: Text('Enrolled Students'),
          centerTitle: true,
        ),
        body:Container(
          child: FutureBuilder(
              future: getEnrolledStudents(),
              builder: (BuildContext, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {


                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext, index) {

                        var firstName = snapshot.data[index].data()["firstName"];
                        var lastName =snapshot.data[index].data()["lastName"];
                        print(firstName);
                        return ListTile(
                          style: ListTileStyle.list,
                          selectedTileColor: Colors.grey,
                          minVerticalPadding: 10,

                          title: Text( '${index+1}.' + ' ' + firstName + ' ' + lastName),
                          trailing: MaterialButton(
                              color: customBrown2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text('Open',
                                style: TextStyle(color: Colors.white),),
                              onPressed: () {
                                //To student Reading report
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder:
                                //         (context) =>
                                //         TopicContent(Topictitle: snapshot.data[index].data()["topic_title"],
                                //             Persona_title:Personatitle, Coursetitle:Coursetitle))
                                // );
                              }

                          ),
                        );
                      });


                } if(snapshot.data == null) {

                  return  Center(child: CircularProgressIndicator());


                }else{

                  return Center(
                      child:Text('No topics Created', style: TextStyle(color: Colors.black),));
                }

              } ),
        )
    );
  }

}