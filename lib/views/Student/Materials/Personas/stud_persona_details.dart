import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:treepy/views/Student/Materials/Personas/stud_persona_list.dart';

class stud_personaDetails extends StatefulWidget {
  final String title;
  const stud_personaDetails({Key? key, required this.title}) : super(key: key);

  @override
  State<stud_personaDetails> createState() => _stud_personaDetailsState();
}
enum Menu { itemOne, itemTwo, itemThree, itemFour }
class _stud_personaDetailsState extends State<stud_personaDetails> {
  late Future _data;
  late String title;
  final auth = FirebaseAuth.instance;
  String? key;



  void initState(){
    super.initState();
    title = widget.title;

  }

  UnenrollPersona() async {
    var db = FirebaseFirestore.instance;
    var uid = FirebaseAuth.instance;
    String? lecID;
    //Use this when you create a separate lec app
    //var uid = FirebaseAuth.instanceFor(app: app)
    

    
    //Delete student from the enrolled students sub-collection of
    // the teaching lec of the current persona
    //Step 1 Get the lec id from the persona document.
    //This is a normal querry there is no need for a composite group querry
    db.collection("users").doc(uid.currentUser?.uid)
        .collection('studentPersonas')
        .where("Persona_title", isEqualTo: title)
        .get().then((QuerySnapshot s) => s.docs.forEach((e) async {
          lecID = e['lecId'];

          //Step 1
          //Delete persona from student personas
          await FirebaseFirestore.instance.collection("users").doc(auth.currentUser!.uid)
              .collection('studentPersonas').doc(title).delete().then(
                (doc) => print("Document deleted"),
            onError: (e) => print("Error updating document $e"),
          );


          //Step 2
      //Do a querry of the personas collection under the path of the obtained lecId.
          //Under the my_personas subcollection
          //for the current persona document.
          //querry the enrolled students subcollection.
          //where the field uid is equal to the current uid
          //delete the document.
      db.collection("Persona")
          .doc(lecID)
          .collection('my_personas')
          .doc(title)
          .collection('enrolled_students')
          .doc(uid.currentUser?.email)
          .delete();


      }));




    Fluttertoast.showToast(
        msg: " " + title + " persona has been deleted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Text('Do you want to unenroll from the ' + title + ' persona?'),


              ],
            ),
          ),
          actions: <Widget>[

            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            SizedBox(height: 10,),

            TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop();

                  Navigator.of(context).pushAndRemoveUntil(
                    CupertinoPageRoute(
                      builder: (BuildContext context) {
                        return studPersonas();
                      },
                    ),
                        (_) => true,
                  );
                  // Navigator.pushReplacementNamed(
                  //     context,
                  //    '/toStud_persona_list');
                  UnenrollPersona();

                }
            )
          ],
        );
      },
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          // This button presents popup menu items.
          PopupMenuButton<Menu>(
            // Callback that sets the selected popup menu item.
              onSelected: (Menu item) {
                setState(() {
                  if (item == Menu.itemOne) {
                    showMyDialog();
                  }
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                const PopupMenuItem<Menu>(
                  value: Menu.itemOne,
                  child: Text('Unenroll from Persona'),
                ),

              ]),
        ],
        leading: BackButton(
          onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context)=>studPersonas())
              );
          },
          color: Colors.white,),
        title: Text(title, style:
        TextStyle(color: Colors.white),),
        //widget.PDetails.data()!["Persona_title"] ,style:
        //         TextStyle(color: Colors.black
        //         ),
      ),body: StreamBuilder<DocumentSnapshot>(
            stream : FirebaseFirestore.instance.collection("users")
                .doc(auth.currentUser!.uid)
                .collection('studentPersonas').doc(title).snapshots(),
            builder: (BuildContext context ,
                AsyncSnapshot<DocumentSnapshot> snapshot){
              if(snapshot.hasData && snapshot.data != null){
                // get the value of the role field
                final courseTitle = snapshot.data!['Course_Title'];
                final PersonaDescription = snapshot.data!['Persona_Description'];


                return Container(
                    child: Card(child:
                    ListTile(
                      title: Text(courseTitle),
                      subtitle: Text(PersonaDescription),
                    ),));
              }
              return Container();
            })
    );
  }

}
