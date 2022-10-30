import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../app_styles.dart';

class studPersonas extends StatefulWidget {
  const studPersonas({Key? key}) : super(key: key);

  @override
  State<studPersonas> createState() => _studPersonasState();
}

class _studPersonasState extends State<studPersonas> {


  late Future _data;
  late String title;
  final auth = FirebaseAuth.instance;




  Future getPersonas() async{
    var auth = FirebaseAuth.instance;
    String? lecID;
    String? personaID;
    var personaKey;
    var uid = auth.currentUser?.uid;
    var db = FirebaseFirestore.instance;


    QuerySnapshot query = db.collectionGroup("enrolled_students")
        .where("uid", isEqualTo: uid)
        .get().then((QuerySnapshot s) => s.docs.forEach((e) {
      lecID = e["lecId"];
      personaID = e["personaID"];

    })) as QuerySnapshot<Object?>;



    return query.docs;

  }



  void initState(){
    _data = getPersonas();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My personas'),
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

                        title: Text('hii'),
                        subtitle:  GestureDetector(
                          onTap: (){



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

                          },
                        ),

                      );

                    });
              }else{
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
