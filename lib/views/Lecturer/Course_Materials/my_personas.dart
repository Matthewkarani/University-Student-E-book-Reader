import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treepy/app_styles.dart';
import 'package:treepy/views/Lecturer/Course_Materials/persona_details.dart';
import 'package:treepy/views/Lecturer/Course_Materials/topic_list_page.dart';

class mypersonas extends StatefulWidget {
  const mypersonas({Key? key}) : super(key: key);

  @override
  State<mypersonas> createState() => _mypersonasState();
}


class _mypersonasState extends State<mypersonas> {

  late Future _data;
  final auth = FirebaseAuth.instance;
   Future getPersonas() async{
    var Firestore = FirebaseFirestore.instance;
     QuerySnapshot qn = await Firestore.collection('Persona').doc(auth.currentUser!.uid)
        .collection('my_personas').get();

     return qn.docs;
   }
  void GoToPersonaDetails(){
     Navigator.push
       (context,
         MaterialPageRoute(builder: (context)=>
     personaDetails()));
  }

  void navigateToTopics(){
     Navigator.push(
       context,
       MaterialPageRoute(builder: (context) =>TopicsList())
     );

  }
  void initState(){
     super.initState();
     _data = getPersonas();
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
        title: Text('My Personas',style:
        TextStyle(
          color: Colors.white
        )),
      ),
          body:Container(
            child: FutureBuilder(
              future: _data,
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
                          onTap: GoToPersonaDetails,
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
                          onPressed:navigateToTopics ,
                        ),

                      );

                    });
              }else{
                  return Center(
                    child: Text('No personas created',style: TextStyle(
                        color:Colors.black ),),
                  );
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
