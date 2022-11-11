import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:treepy/Notifiers/Persona_Notifier.dart';
import 'package:treepy/app_styles.dart';


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

  String? firstName;

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


  Widget buildFirstName(){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users')
          .doc(auth.currentUser?.uid).snapshots(),
        builder:(BuildContext context ,
            AsyncSnapshot<DocumentSnapshot> snapshot){
         firstName= snapshot.data!['first name'];

        return Text(firstName!+ '!',style :TextStyle(
          color: customBrown2,
            fontSize: 22,fontWeight: FontWeight.bold
        ));

        });
  }

  Widget buildCreatedPersona() =>
      Text('Created Persona\'s',style: TextStyle(
          fontSize: 18,
          decoration:TextDecoration.underline ),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lecturer Home'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
            child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    //Row to hold the Good morning Lecturer Widget

                   SizedBox(
                     height: 30,
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 30.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text('Good ' + greeting() ,
                               style: TextStyle(
                                 color: customBrown2,
                                 fontSize: 22,fontWeight: FontWeight.bold
                               ),),
                             SizedBox(width: 5,),
                             buildFirstName()
                           ],
                         ),
                       ),
                   ),

                    //Created Personas Title








                  ],
                )),
          )
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