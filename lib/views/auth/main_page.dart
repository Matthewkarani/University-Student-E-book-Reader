import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:treepy/views/Lecturer/Home/Home_lec.dart';
import 'package:treepy/views/auth/auth_helper.dart';

import 'package:treepy/views/home_page.dart';
import 'package:treepy/views/pages.dart';

import '../Lecturer/btm_nav_page.dart';
import '../Student/std_btm_nav_page.dart';
import 'auth_page.dart';
import 'getusertype.dart';


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            UserHelper.saveUser(snapshot.data);
            return StreamBuilder<DocumentSnapshot>(
                stream : FirebaseFirestore.instance.collection("users")
                    .doc(snapshot.data?.uid).snapshots(),
                builder: (BuildContext context ,
                    AsyncSnapshot<DocumentSnapshot> snapshot){
                  if(snapshot.hasData && snapshot.data != null){
                   // get the value of the role field
                    final userRole = snapshot.data!['role'];
                    if(userRole != 'Student'){
                      return LecBtmNav();
          }else{
                      return StdLanding();
                    }
          //then extract the specific fields
          }
                  return Material(
                      child: Center(child: CircularProgressIndicator(),));
          });

          }
          return AuthPage();
        },
      ),
    );
  }
}


