import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetUserType extends StatefulWidget {
  const GetUserType({Key? key}) : super(key: key);

  @override
  State<GetUserType> createState() => _GetUserTypeState();
}

class _GetUserTypeState extends State<GetUserType> {

  @override
  Widget build(BuildContext context) {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final uid = user?.uid;
      CollectionReference student = FirebaseFirestore.instance.collection('users');
      return FutureBuilder<DocumentSnapshot>(
          future: student.doc(uid).get(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            //Error Handling conditions
            if(snapshot.hasData){
              var role = snapshot.data!['role'];


            }
            return Text('User not registed'); }
      );
    }
  }


