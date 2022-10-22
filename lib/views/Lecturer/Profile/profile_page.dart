import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../app_styles.dart';

class LecsProfile extends StatefulWidget {
  const LecsProfile({Key? key}) : super(key: key);

  @override
  State<LecsProfile> createState() => _LecsProfileState();
}


class _LecsProfileState extends State<LecsProfile> {

  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Signed In as: '+user.email!,
              ),
              MaterialButton(
                  color: customBrown,
                onPressed: (){
                FirebaseAuth.instance.signOut();
              },

                child: Text('Sign Out',style: TextStyle(
                    color: Colors.white),),)
            ],
          ),
        ),
      ),
    );
  }
}
