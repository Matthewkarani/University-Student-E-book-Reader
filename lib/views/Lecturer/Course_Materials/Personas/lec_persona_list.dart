import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treepy/app_styles.dart';
import 'package:treepy/views/Lecturer/Course_Materials/Personas/persona_details.dart';
import 'package:treepy/views/Lecturer/Course_Materials/Topics/topic_list_page.dart';

import '../../report_pages/lec_reportsHomeNav.dart';
import 'create_persona.dart';

class mypersonas extends StatefulWidget {
  const mypersonas({Key? key}) : super(key: key);

  @override
  State<mypersonas> createState() => _mypersonasState();
}


class _mypersonasState extends State<mypersonas> {

  late String title;
  late Future _data;
  final auth = FirebaseAuth.instance;
  Future getPersonas() async{
    var Firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await Firestore.collection('Persona').doc(auth.currentUser!.uid)
        .collection('my_personas').get();

    return qn.docs;


  }



  ToAddPersonaPage(){
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context)=> createPersona()));
  }
  void initState(){
    _data = getPersonas();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton:FloatingActionButton(
          child: Icon(Icons.add, semanticLabel: 'Add Persona',),
          onPressed: (){
            ToAddPersonaPage();
          },
        ) ,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.more_horiz),
            )
          ],
          centerTitle: true,
          title: Text('My Personas',style:
          TextStyle(
              color: Colors.white
          )),
        ),
        body:Container(
          child: FutureBuilder(
              future: getPersonas(),
              builder: (BuildContext, snapshot){
                if(snapshot.hasData && snapshot.data != null){

                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext,index){

                        return ListTile(

                          style: ListTileStyle.list,
                          selectedTileColor: Colors.grey,

                          minVerticalPadding: 10,

                          title: Text(snapshot.data[index].data()["Persona_title"]),
                          subtitle:  GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      personaDetails(title:snapshot.data[index].data()["Persona_title"] ) )
                              );

                            },
                            child: Text('See Details', style:
                            TextStyle(color: Colors.blue),
                            ),
                          ),

                          trailing: MaterialButton(
                            color: customBrown2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text('Open',style:
                            TextStyle(color: Colors.white),),
                            onPressed:(){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder:
                                      (context) =>TopicsList(
                                        Coursetitle: snapshot.data[index].data()["Course_Title"],
                                        Personatitle: snapshot.data[index].data()["Persona_title"],
                                          ),)
                              );
                            },
                          ),

                        );

                      });
                }else if(snapshot.data == null) {
                  return
                    Center(child: CircularProgressIndicator());


                } else{
                  //Find a way of displaying this
                  return Center(

                      child:Text('No topics Created',style:
                      TextStyle(color: Colors.black),));

                }


              } )
            //itembulder takes in a function that builds the list .
            //The itembuilder function(), takes the build context and an index.

          ,
        )

    );

  }
}