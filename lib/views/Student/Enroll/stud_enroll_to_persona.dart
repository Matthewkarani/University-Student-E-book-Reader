

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../app_styles.dart';
import '../Home/stud_home_page.dart';
import '../Home/mypersonas.dart';
import '../Materials/Personas/stud_persona_list.dart';

class EnrollPersona extends StatefulWidget {
  const EnrollPersona({Key? key}) : super(key: key);

  @override
  State<EnrollPersona> createState() => _EnrollPersonaState();
}

class _EnrollPersonaState extends State<EnrollPersona> {
  late bool _passwordVisible;
  final _personaKeycontroller = TextEditingController();

  late String key;


  @override
  void dispose() {
    _personaKeycontroller.dispose();
    super.dispose();
  }



  Future enrollStudent() async{
    var auth = FirebaseAuth.instance;
    var uid = auth.currentUser?.uid;
    var db = FirebaseFirestore.instance;
    bool dbKey = false;
    //Stores for student details doc
    String? lastName;
    String? firstName;

    //details for student's my persona documents
    String? Persona_title;//Is also the persona doc key & persona ID
    String? Course_Title;
    bool? isPersona;
    String? Persona_Description;
    String? Persona_key;
    String? lecID;
    //personaID is the personaTitle - for now

    //Initializing the variables
    Persona_key = _personaKeycontroller.text.trim();
if(Persona_key.isEmpty){
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content : Text('Enter Key')),
  );

  return ;
}else if(!Persona_key.isEmpty){

  db.collectionGroup("my_personas")
      .where("Persona_key", isEqualTo:Persona_key)
      .get().then((QuerySnapshot s) => s.docs.forEach((e) {
    //!e cannot exist at this point e will always exist.
    setState(() {
      dbKey = true;
      //get details of persona doc
      Persona_title = e['Persona_title'];
      Course_Title = e['Course_Title'];
      Persona_Description = e['Persona_Description'];
      lecID = e['lecID'];
    });
    print(dbKey);

    //Enroll student
    //first get student details
    db.collection("users")
        .where("uid", isEqualTo:uid)
        .get().then((QuerySnapshot s) => s.docs.forEach((e) {
      setState(() {
        firstName = e["first name"];
        lastName = e["last name"];
      });

      //Map the student details to a variable(storage container)
      final studentDetails = <String,dynamic>{
        'firstName':firstName,
        'lastName':lastName,
        'uid':uid,
        'lecID':lecID
      };

      print(lecID);
      //Create a 'enrolled student' sub-collection under the persona document
      FirebaseFirestore.instance.collection('Persona').doc(lecID)
          .collection('my_personas')
          .doc(Persona_title)
          .collection('enrolled_students')
          .doc(auth.currentUser?.email).set(studentDetails);

      print(Persona_title);


      //Create a variable for storing a duplicate version of the persona doc
      //under the student users collection so that every time the lecturer uploads
      //material, carry out a collection group querry and for each document,
      //create a copy of the material that the lecturer has uploaded.

      var personaData = <String,dynamic>{
        'Course_Title' : Course_Title,
        'IsPersona' : true,
        'Persona_Description': Persona_Description,
        'Persona_key': Persona_key,
        'Persona_title': Persona_title ,
        'lecId' : lecID,
        'personaID' : Persona_title
      };

      print(personaData);

      //Create a student_persona sub-collection under the student
      //user document.
      db.collection('users').doc(uid)
          .collection('studentPersonas').doc(Persona_title).set(personaData);

      Navigator.push(context,
          MaterialPageRoute(builder:
              (context)=>studPersonas()));








    }));



      }
  ));

  //Sort this validation for if the persona Key is invalid
 /* if(dbKey == false){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content : Text('Invalid Key')),
    );
return;
  }*/

}










 //Querry 1 get persona Details and persona doc details


  }



  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Enroll to Persona', style:
        TextStyle(
          fontWeight: FontWeight.bold,
          wordSpacing: 2,),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [

                SizedBox(height: 200,),


                Text('Enter Persona Key',
                    style: TextStyle(color: Colors.black,
                        fontSize: 22)),

                SizedBox(height: 20,),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                        obscureText: !_passwordVisible,
                        controller: _personaKeycontroller,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {

                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            border: InputBorder.none, hintText: 'Enter key here')),
                  ),
                ),

                SizedBox(height:30),

                MaterialButton(
                    color: customBrown2,
                    child: Text('enroll'),
                    onPressed: enrollStudent)




              ],
            ),
          ),
        ),
      ),
    );
  }
}


















  /*
  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text('Enroll to Persona', style:
      TextStyle(
      fontWeight: FontWeight.bold,
      wordSpacing: 2,),),
    ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [

                SizedBox(height: 200,),


                Text('Enter Persona Key',
                      style: TextStyle(color: Colors.black,
                          fontSize: 22)),

                SizedBox(height: 20,),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                      obscureText: !_passwordVisible,
                        controller: _personaKeycontroller,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                            ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {

                            _passwordVisible = !_passwordVisible;
                            });
                            },
                          ),
                            border: InputBorder.none, hintText: 'Enter key here')),
                  ),
                ),

                SizedBox(height:30),

            MaterialButton(
              color: customBrown2,
              child: Text('enroll'),
                onPressed: enrollStudent)




              ],
            ),
          ),
        ),
      ),
    );
  }
}

*/
/*What do i want to do?
     * I want to enroll a student to a specific persona of
     * which they have entered the correct persona key.
     * How do you hope to archieve that? Once the student enters
     * the persona key, there is a collection group querry that is done on
     * the personas collection of all the documents and their respective
     * my_personas sub-collections and all the created personas are crawled through
     * If the persona key is found to match with any of the persona key's in that group,
     * the student is to be enrolled on to the specific persona with their uid and name , else return persona key invalid */

/*query.documents.forEach((DocumentSnapshot doc) {
       print(doc.data);
       print(doc.exists);
       print(doc.id.toString());

     });*/



// print(query) ;


/*  personaKey = _personaKeycontroller.toString();
     var Firebase = FirebaseFirestore.instance;
     late String DocKey;

     //Create a reference to the my_personas sub collection.

     final personasRef = await Firebase.collection("Persona").doc()
         .collection('my_personas');
     //Create an array field in the persona related to the persona Key that
     // is named enrolled student.
*/
// Create a query against the collection.
/*final personaRef =
    FirebaseFirestore.instance.collection('_persona');
    var cityone = <String,dynamic>{
      'city' : 'Mumbai',
      'state': 'MH',
      'country': 'INDIA'
    };

    var citytwo = <String,dynamic>{
      'city' : 'Mumbai',
      'state': 'MH',
      'country': 'INDIA'
    };*?






   /* newCollection.add(citytwo).then((DocumentReference d) =>
    print ('First document added successfully: ${d.id}'));

    await newCollection.get().then((event) {
    for(final doc in event.docs){
      print('${doc.id}=> ${doc.data()}');
    };
    });*/
    //final documentReference = newCollection.doc('xi0Vaw8OBkyGGdHaGO8x');
    /*print(documentReference.parent);
    print(documentReference.path);
    print(documentReference.id);
    print(documentReference.snapshots());
    */

*/


