import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:treepy/views/Student/Materials/Personas/stud_persona_details.dart';
import 'package:treepy/views/Student/Materials/Personas/stud_topic_content.dart';
import 'package:treepy/views/Student/Materials/Personas/stud_topic_list.dart';

import '../../../../app_styles.dart';
import '../../Enroll/stud_enroll_to_persona.dart';
import '../../Home/stud_home_page.dart';
import '../../Profile/stud_profile.dart';
import '../Scheduler/Schedule_home.dart';


class studPersonas extends StatefulWidget {
  const studPersonas({Key? key}) : super(key: key);

  @override
  State<studPersonas> createState() => _studPersonasState();
}

class _studPersonasState extends State<studPersonas> {



  late Future _data;
  late String title;
  final auth = FirebaseAuth.instance;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future getPersonas() async{
    var Firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await Firestore.collection('users').doc(auth.currentUser!.uid)
        .collection('studentPersonas').get();

    return qn.docs;


  }


  void initState(){
    _data = getPersonas();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(


          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(

                decoration: BoxDecoration(
                  color: Color(0xffc19236),
                ),
                child: Text('Persona Dashboard',
                  style: TextStyle(color: Colors.white, fontSize: 20),),
              ),
              ListTile(
                title: const Text('Enroll to Persona'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder:
                              (context)=>EnrollPersona()));
                  scaffoldKey.currentState!.closeDrawer();
                },
              ),
              ListTile(
                title: const Text('My Schedules'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder:
                              (context)=>scheduler_home()));
                  scaffoldKey.currentState!.closeDrawer();
                },
              ),
              ListTile(
                title: const Text('My Profile'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder:
                              (context)=>studProfile()));
                  scaffoldKey.currentState!.closeDrawer();
                },
              ),

            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.more_horiz),
              ),
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
                                      stud_personaDetails(title:snapshot.data[index].data()["Persona_title"] ) )
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
                                      (context) =>studTopicsList(
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

                      child:Text('No topics Created'));

                }


              }
            //itembulder takes in a function that builds the list .
            //The itembuilder function(), takes the build context and an index.




          )
          ,
        )

    );

  }
}