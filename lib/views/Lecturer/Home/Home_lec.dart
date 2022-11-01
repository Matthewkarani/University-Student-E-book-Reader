import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:treepy/Notifiers/Persona_Notifier.dart';


import '../../../../model/Pesona_card_model_data.dart';
import '../../../../model/persona_model.dart';
import '../Course_Materials/Personas/Persona Materials.dart';

class LecHome extends StatefulWidget {
  const LecHome({Key? key}) : super(key: key);

  @override
  State<LecHome> createState() => _LecHomeState();
}

class _LecHomeState extends State<LecHome> {
  get persona => null;



 late String UserName;
  late final String Title;

  get data => null;
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  getuserName() async{
    var auth = FirebaseAuth.instance;
    var uid = auth.currentUser?.uid;
    var db = FirebaseFirestore.instance;
    String? firstName;
    String? lastName;
    String? personakey;
    String? Course_Title;
    String? Persona_Description;
    String? Persona_key;
    String? Persona_title;
    String? lecID;
    String? personaId;

    db.collection("Persona")
        .doc(lecID)
        .collection('my_personas')
        .where("personaID", isEqualTo: '123456')
        .get().then((QuerySnapshot s) => s.docs.forEach((e) {
      Course_Title = e["Course_Title"];
      Persona_Description = e["Persona_Description"];
      Persona_key = e["Persona_key"];
      Persona_title = e["Persona_title"];


    }));

    print(Persona_title);
  }
  final auth = FirebaseAuth.instance;
  getPersonaTitle() async{
await FirebaseFirestore.instance
      .collection('Persona').doc(auth.currentUser!.uid).
 collection("my_personas")
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      var Doc = (doc["Persona_title"]);

    });
  });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Good ' + greeting() , style: TextStyle(
        ),),
      ),
      body: SafeArea(
          child: Center
            (
              child: MaterialButton(
                child: Text('test'),
            onPressed: getuserName,

          ))

      ),
    );
  }
}
  buildPersonas(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Personas', style: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w800,)),
      ],
    );

  }




         //You need to query the my persona's subcollection and return the n
         // names of the collection,or,for each persona made , save the title in a
          //document and querry that.
          //or use the where operator
          //where is persona is true return the persona title , save it in an array
          //then display the array in the item count.








  //model class
//To Create a persona, have the lecturer type in the name of the persona,
// extract the persona name and use it as the document id in firebase.
//let the other things that they input be the persona doc fields.

//Whenever a student enrolls to the persona, let a subcollection named
//enrolled students be formed.

//Whenever a lecturer adds notes , let a subcollection be formed, with the doc id's
//as the topic/ doc id - auto generated.

//Whenever a lecturer adds videos , let a subcollection be formed named
//persona videos.

//The actual assets will be stored in the firebase storage, the subcollections
//will be for reference.

//learn how to use models, you need to start using them.

/*body: ListView.builder(
// Let the ListView know how many items it needs to build.
itemCount: items.length,
// Provide a builder function. This is where the magic happens.
// Convert each item into a widget based on the type of item it is.
itemBuilder: (context, index) {
final item = items[index];

return ListTile(
title: item.buildPersonaTitle(context),
subtitle: item.buildCourseTitle(context),
);
},
)
);*/

/*
 Center(child: Text(" Good " + greeting(),
                style: GoogleFonts.roboto
                  (fontSize: 28,
                    fontWeight: FontWeight.bold),)
              ),
              buildPersonas(context),
              SizedBox(height: 20.0),
              Container(color: Colors.red,
                  height: 50,
                  width: 2,
                  child: Text("Get Persona's")
              )
              ,
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 30,
                  width: 30,

                  child: MaterialButton(
                      child: Text('Create Persona'),


                      onPressed: (){

                        Navigator.pushReplacement (context,MaterialPageRoute(builder:
                            (context) => const PersonaMaterial()
                        )
                        );
                      },
                  ),
                ),
              ),




 */