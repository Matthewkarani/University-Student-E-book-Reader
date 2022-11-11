import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:treepy/views/Lecturer/report_pages/lec_reportsHomeNav.dart';

import '../../../app_styles.dart';
import '../Course_Materials/Personas/create_persona.dart';
import '../Course_Materials/Topics/topic_list_page.dart';

class LecReport extends StatefulWidget {
  const LecReport({Key? key}) : super(key: key);

  @override
  State<LecReport> createState() => _LecReportState();
}

class _LecReportState extends State<LecReport> {



  late String title;
  late Future _data;
  final auth = FirebaseAuth.instance;
  Future getPersonas() async{
    var Firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await Firestore.collection('Persona').doc(auth.currentUser!.uid)
        .collection('my_personas').get();

    return qn.docs;


  }


  void initState(){
    _data = getPersonas();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.more_horiz),
            )
          ],
          centerTitle: true,
          title: Text('Persona Reports',style:
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
                                      (context) =>reportsHomeNav(
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


              } )
          //itembulder takes in a function that builds the list .
          //The itembuilder function(), takes the build context and an index.

          ,
        )

    );

  }
}