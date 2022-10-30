

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../app_styles.dart';
import '../Home/stud_home_page.dart';

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


    //add verification checks as how eg if persona key not found return invalid key
    var auth = FirebaseAuth.instance;
    var uid = auth.currentUser?.uid;
    var db = FirebaseFirestore.instance;
    String? lecID;
    String? lastName;
    String? firstName;
    String? personakey;
    String? personaId;
    personakey = _personaKeycontroller.text.trim();

    db.collectionGroup("my_personas")
        .where("Persona_key", isEqualTo: personakey)
        .get().then((QuerySnapshot s) => s.docs.forEach((e) {
          //get document id

      personaId = e.id;

      //Get lec id
      lecID = e["lecId"];
      //get the student details (first name and last name)
      // Add data to the student document
      print(personaId);

      db.collection("users")
          .where("uid", isEqualTo: uid)
          .get().then((QuerySnapshot s) => s.docs.forEach((e) {
        firstName = e["first name"];
        lastName = e["last name"];
      }));

      var studentDetails = <String,dynamic>{
        'first_name' : 'Matthew',
        'last_name' : 'Karani',
        'personaID' :personaId,
        'uid' : uid,
        'lecId' : lecID
      };



      //Enroll the student to the persona with that persona id
      FirebaseFirestore.instance.collection('Persona').doc(lecID)
          .collection('my_personas')
          .doc(personaId)
          .collection('enrolled_students')
          .doc(auth.currentUser?.email).set(studentDetails);
    }));


    //Retrieve all fields of the current persona.






    //Create a variable for stroring the retrieved persona data
/*    var personaData = <String,dynamic>{
       'Course_Title' :,
        'IsPersona' :,
            'Persona_Description':,
        'Persona_key': ,
     'Persona_title': ,
      'lecId'



    };*/

    //Create new my Personas Collection for the users.
  /*  FirebaseFirestore.instance.collection('users').doc(uid)
        .collection('studentPersonas').add(personaData);
    //Redirect to persona page
    Navigator.push(context,
        MaterialPageRoute(builder: (context)=>StudHome()));*/

    Fluttertoast.showToast(
            msg: "Enrollment Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );

















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
