import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../app_styles.dart';

class studProfile extends StatefulWidget {
  const studProfile({Key? key}) : super(key: key);

  @override
  State<studProfile> createState() => _studProfileState();
}

class _studProfileState extends State<studProfile> {
  late bool getPoints;
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;
  String? CurrentPoints;
  String? getCurrentScore(){
    var uid = auth.currentUser?.uid;
  final docRef =  db.collection("users").doc(uid);
  docRef.snapshots().listen(
  (event) {
        CurrentPoints = event['ReadingPoints']. toString();
        // print("current data: ${event.data()}");

        setState(() {
          getPoints = true;
        });
        // // onError:
        //     (error) => print("Listen failed: $error");
      });


  return CurrentPoints;
}
 CalculateAverageReadingTime(){

}

CalculateTotalReadingTime(){

}






  Widget BuildReadingStreak()=>Text("");

  Widget BuildBooksRead()=>  FutureBuilder(
  future: getBooksNo(),
  builder: (BuildContext, snapshot) {
    return Text('');
   });


  Widget BuildAverageReadingTime()=> Text('data');


  Widget BuildTotalReadingTime() => Text('');






@override
  void initState() {
  getPoints = false;
    super.initState();
  }


  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    getCurrentScore();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          title : Text('My Profile', style: TextStyle(
              fontWeight:FontWeight.bold))
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(

            children: [
              SizedBox(height: 10,),

              //Profile Picture
              CircleAvatar(

                backgroundColor: Colors.grey,
                  radius : 75,
                child:
                Icon(Icons.person,
                size: 75,color: Colors.black,),
              ),

              SizedBox(height: 10,),
              //Username Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal : 25.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text('UserName : ' + user.email!,//Chang
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              //Title : Reading Report
              Padding(
                padding: const EdgeInsets.symmetric(horizontal : 25.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Reading Report',
                      style: TextStyle(fontSize: 22,
                          decoration: TextDecoration.underline),
                  ),

                ),
              ),


              SizedBox(height: 10,),
              //Title : Reading Streak
              Padding(
                padding: const EdgeInsets.symmetric(horizontal : 25.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Reading Streak',
                      style: TextStyle(fontSize: 15)),
                ),
              ),
              SizedBox(height: 5,),
              //Display View :EG 5 Days
              Padding(
                padding: const EdgeInsets.symmetric(horizontal : 25.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration:
                    BoxDecoration(
                        color :Colors.grey[200],
                        shape: BoxShape.rectangle
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          '5 days'
                      ),
                    ),
                  ),
                ),
              ),


              SizedBox(height: 5,),
              //Title : Total Books Read
              Padding(
                padding: const EdgeInsets.symmetric(horizontal : 25.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Reading Points',
                      style: TextStyle(fontSize: 15)),
                ),
              ),
              SizedBox(height: 5,),
              //Display View
              Padding(
                padding: const EdgeInsets.symmetric(horizontal : 25.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration:
                    BoxDecoration(
                        color :Colors.grey[200],
                        shape: BoxShape.rectangle
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  Text('${getCurrentScore()} Points')
                      ),
                    ),
                  ),
                ),

              SizedBox(height: 10,),
              //Title : Average daily Reading time
              Padding(
                padding: const EdgeInsets.symmetric(horizontal : 25.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(' Daily Average Reading Time',
                      style: TextStyle(fontSize: 15)),
                ),
              ),
              SizedBox(height: 10,),
              //Display View : 2 Hours
              Padding(
                padding: const EdgeInsets.symmetric(horizontal : 25.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration:
                    BoxDecoration(
                        color :Colors.grey[200],
                        shape: BoxShape.rectangle
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          '2 hours'
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10,),
              //Title : Total Reading Time
              Padding(
                padding: const EdgeInsets.symmetric(horizontal : 25.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Total Reading Time',
                      style: TextStyle(fontSize: 15)),
                ),
              ),
              SizedBox(height: 10,),
              //Display View : 10 Hours
              Padding(
                padding: const EdgeInsets.symmetric(horizontal : 25.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration:
                    BoxDecoration(
                        color :Colors.grey[200],
                        shape: BoxShape.rectangle
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          '10 hours'
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                    color: customBrown,
                    child: Text('Sign Out',style: TextStyle(
                        color: Colors.white),),),

                ),
              ),
              SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }

  getBooksNo() {}
}
