import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treepy/app_styles.dart';
import 'package:treepy/views/Lecturer/Course_Materials/Topics/topic_content_page.dart';

import 'addTopic.dart';

class TopicsList extends StatefulWidget {
  final String title;
  const TopicsList({Key? key, required this.title}) : super(key: key);

  @override
  State<TopicsList> createState() => _TopicsList();
}

class _TopicsList extends State<TopicsList> {

  //VoidCallback void() is a function which takes no parameters
  // and returns no parameters.
  // In Flutter it is also true.
  // Sometimes we call it simply callback.
  late String title;

  late Future _data;
  final auth = FirebaseAuth.instance;

  Future getTopics() async {
    var Firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await Firestore.collection('Topics')
        .doc(title).collection('My_Topics').get();

    return qn.docs;
  }

  @override
  void initState() {
    title = widget.title;
    _data = getTopics();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, semanticLabel: 'Add Topic',),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => addTopic(title: title,)));
          },
        ),
        appBar: AppBar(
          actions: [
            Icon(Icons.more_horiz)
          ],
          leading: BackButton(),
          title: Text('Course Name : '+ title,
            style: TextStyle(fontSize: 22
            ),),
          centerTitle: true,
        ),
        body:Container(
          child: FutureBuilder(
            future: _data,
            builder: (BuildContext, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {


                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext, index) {


                      return ListTile(
                        style: ListTileStyle.list,
                        selectedTileColor: Colors.grey,
                        minVerticalPadding: 10,

                        title: Text('Topic: '+snapshot.data[index].data()["topic_title"]),
                        trailing: MaterialButton(
                            color: customBrown2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text('Open',
                              style: TextStyle(color: Colors.white),),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder:
                                      (context) =>
                              TopicContent(Topictitle: snapshot.data[index].data()["topic_title"],Persona_title: title))
                              );
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