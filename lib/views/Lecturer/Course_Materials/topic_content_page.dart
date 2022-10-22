import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:treepy/app_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:treepy/views/Lecturer/Course_Materials/camera_page.dart';
import 'package:treepy/views/Lecturer/Course_Materials/uploadNotes.dart';

import 'topic_list_page.dart';

class TopicContent extends StatefulWidget {
  const TopicContent({Key? key}) : super(key: key);

  @override
  State<TopicContent> createState() => _TopicContentState();
}

class _TopicContentState extends State<TopicContent> {



  GoToCameraPage(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=> CameraPage())
    );
  }

  Future selectFile() async{
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=> uploadNotes()));



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
        leading: BackButton(),
        title: Text('Topic Number',
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
