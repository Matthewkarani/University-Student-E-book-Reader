import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:treepy/app_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:treepy/views/Lecturer/Course_Materials/Uploads/camera_page.dart';
import 'package:treepy/views/Lecturer/Course_Materials/Personas/persona_details.dart';
import 'package:treepy/views/Lecturer/Course_Materials/Uploads/uploadNotes.dart';

import 'UpdateTopicPage.dart';
import 'topic_list_page.dart';

class TopicContent extends StatefulWidget {
  final String Topictitle;
  final String Persona_title;
  const TopicContent(
      {Key? key,
        required this.Topictitle,
    required this.Persona_title}) : super(key: key);

  @override
  State<TopicContent> createState() => _TopicContentState();
}

class _TopicContentState extends State<TopicContent> {



  late String Topictitle;
  late String Personatitle;
  @override
  void initState() {
    Topictitle = widget.Topictitle;
    Personatitle = widget.Persona_title;

    super.initState();
  }

  Future DeletePersona() async {


    await FirebaseFirestore.instance.collection("Topics").doc(Topictitle)
        .collection('My_Topics').doc(Topictitle).delete().then(
          (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
  }

  GoToCameraPage(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=> CameraPage(Persona_title:Personatitle,))
    );
  }

  Future selectFile() async{
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=> uploadNotes(Personatitle:Personatitle)));
  }

  UpdatePersonaDetailsPage() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>UpdateTopic()));

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
                Text('Do you want to delete the ' + Topictitle + ' topic?'),


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
                      MaterialPageRoute(builder: (context)=>TopicsList(title: '')));
                  DeletePersona();

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

      //consider adding two floating action buttons , if possible,
      // one for adding notes, the other for adding videos
      floatingActionButton: SpeedDial(
        spaceBetweenChildren: 12,
        spacing: 12,
        overlayColor: customBrown2,
        overlayOpacity: 0.4,
        icon : Icons.add,
        children: [
          SpeedDialChild(
            child: Icon(Icons.book),
            label: 'Add Notes',
            onTap: selectFile,
            backgroundColor: customBrown2,
              foregroundColor: Colors.white

          ),
          SpeedDialChild(
              child: Icon(Icons.video_camera_front_outlined),
              label: 'Summary Video'
              , onTap: GoToCameraPage,
              backgroundColor: customBrown2,
              foregroundColor: Colors.white
    )
        ],
      ),
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
                    showMyDialog();
                  }

                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                const PopupMenuItem<Menu>(
                  value: Menu.itemOne,
                  child: Text('Edit Topic Details'),
                ),
                const PopupMenuItem<Menu>(
                  value: Menu.itemTwo,
                  child: Text('Delete Topic'),
                ),

              ]),
        ],
        leading: BackButton(),
        title: Text(Topictitle + ' Content',
          style: TextStyle(fontSize: 22
          ),),
        centerTitle: true,
      ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),



                //Edit Summary Videos row
                //title
                Text('Summary Video',style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 22
                ),),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          color: Colors.grey,
                          height: 100,
                          width: 200,
                          child: Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.play_arrow)),
                        ),
                        SizedBox(width: 30),
                        Column(
                          children: [
                            MaterialButton(
                              onPressed: (){},
                              color: customBrown2,
                              child: Text('Edit',
                                  style: TextStyle(color: Colors.white)
                              ),),
                            SizedBox(height: 10,),
                            MaterialButton(onPressed: (){},
                              color: customBrown2,
                              child: Text('Delete',
                                style: TextStyle(color: Colors.white),),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 50,),




                //Edit summary notes

//title
                Text('Notes',style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 22
                ),),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // Find a way to wrap the container , and two buttons
                        //into some sort of card so that they are one object.
                        Container(
                          color: Colors.grey,
                          height: 100,
                          width: 200,
                          child: Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.book,
                                  size:30) ),
                        ),
                        SizedBox(width: 30),
                        Column(
                          children: [
                            MaterialButton(
                              onPressed: (){},
                              color: customBrown2,
                              child: Text('Edit',
                                  style: TextStyle(color: Colors.white)
                              ),),
                            SizedBox(height: 10,),
                            MaterialButton(onPressed: (){},
                              color: customBrown2,
                              child: Text('Delete',
                                style: TextStyle(color: Colors.white),),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),


                SizedBox(height: 200,),
                //Add New Topic Button


              ],
            ),
          ),

        )
    );
  }
}
