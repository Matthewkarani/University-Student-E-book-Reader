import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import '../../../model/persona_model.dart';
import '../../auth/auth_helper.dart';
import 'UpdatePersona.dart';
import 'my_personas.dart';

enum Menu { itemOne, itemTwo, itemThree, itemFour }

class personaDetails extends StatefulWidget {
  final String title;
  const personaDetails({Key? key, required this.title}) : super(key: key);

  //Our detail page can now receive a persona detail object which is of the type
  //Documentsnapshot as a parameter
  //personaDetails({required this.PDetails});


  @override
  State<personaDetails> createState() => _personaDetailsState();
}

class _personaDetailsState extends State<personaDetails> {
  //we then use the Details object inside the _personaDetails state

  late Future _data;
  late String title;
  final auth = FirebaseAuth.instance;
  String? key;

  Future DeletePersona() async{

    await FirebaseFirestore.instance.collection("Persona").doc(auth.currentUser!.uid)
        .collection('my_personas').doc(title).delete().then(
          (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );



    Fluttertoast.showToast(
        msg: "Your " + title + " persona has been deleted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  UpdatePersonaDetailsPage() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>UpdatePerona(title: title,)));

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
                Text('Do you want to delete the ' + title + ' persona?'),


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
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>mypersonas()));
                  DeletePersona();

                }
            )
          ],
        );
      },
    );
  }


  void initState(){
    super.initState();
    title = widget.title;

  }
  String _selectedMenu = '';

  getPersonaKey() async {
    var Firebase = FirebaseFirestore.instance;
    var auth = FirebaseAuth.instance;

    final snapshot = await Firebase.collection('Persona').
    doc(auth.currentUser!.uid).collection('my_personas')
        .doc(title).get();
    key = snapshot.data()!['Persona_key'];


    await Clipboard.setData(ClipboardData(text: key ));
    Fluttertoast.showToast(
        msg: "Persona Key Saved On Clipboard",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );


  }
    

   SavePersonaKey() async {


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
                      UpdatePersonaDetailsPage();
                    } else if (item == Menu.itemTwo) {
                      getPersonaKey();
                    }else if (item == Menu.itemThree) {
                      showMyDialog();
                    }

                  });
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                  const PopupMenuItem<Menu>(
                    value: Menu.itemOne,
                    child: Text('Edit Persona Details'),
                  ),
                  const PopupMenuItem<Menu>(
                    value: Menu.itemTwo,
                    child: Text('Get persona key'),
                  ),
                  const PopupMenuItem<Menu>(
                    value: Menu.itemThree,
                    child: Text('Delete Persona'),
                  ),

                ]),
          ],
          leading: BackButton(color: Colors.white,),
          title: Text(title, style:
          TextStyle(color: Colors.white),),
          //widget.PDetails.data()!["Persona_title"] ,style:
          //         TextStyle(color: Colors.black
          //         ),
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream : FirebaseFirestore.instance.collection("Persona")
                .doc(auth.currentUser!.uid)
                .collection('my_personas').doc(title).snapshots(),
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


