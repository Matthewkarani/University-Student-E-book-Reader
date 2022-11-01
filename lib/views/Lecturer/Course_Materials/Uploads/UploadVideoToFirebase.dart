import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:treepy/views/Lecturer/Course_Materials/Topics/topic_content_page.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';


import '../../../../app_styles.dart';
import 'UploadVideoToFirebase.dart';

class UploadVideoToFirebase extends StatefulWidget {
  final String filePath;
  final String Personatitle;

  const UploadVideoToFirebase({Key? key, required this.filePath,  required this.Personatitle}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<UploadVideoToFirebase> {

  UploadTask? uploadTask;
  late  String Personatitle;
  @override
  void initState() {
    Personatitle= widget.Personatitle;
    super.initState();
  }

  @override

  Future uploadToFirebase() async {
    var auth = FirebaseAuth.instance;
    var uid = auth.currentUser?.uid;
    var db = FirebaseFirestore.instance;
    String? Persona_key;

    Persona_key = Personatitle;
    final file = File(widget.filePath);
    final path = 'videos/${VideoPlayerController.file(file)}';

    final ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = ref.putFile(file);
    });

    //wait for the upload task to get completed
    final snapshot = await uploadTask!.whenComplete(() => {


    });
    //On completion, get the download url.
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link : $urlDownload');

    Navigator.push(context,
        MaterialPageRoute(builder: (context)=>
            TopicContent(Topictitle: '', Persona_title: '')));





   //get the persona Doc from firebase

      db.collectionGroup("my_personas")
          .where("Persona_key", isEqualTo:Persona_key)
          .get().then((QuerySnapshot s) => s.docs.forEach((e) {

            //create a variable to carry the video donload link
        var videoDownloadlink = <String, dynamic>{
          'videoLink': [urlDownload]
        };

       //update persona Document
        db.collection('Persona').
        doc(uid)
        .collection('my_personas')
        .doc(Persona_key)
        .update(videoDownloadlink);

        Fluttertoast.showToast(
          gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            msg: 'Video Uploaded');

      }));




    //after the upload task is finished set the upload task to null
    setState(() {
      uploadTask = null;
    });


  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>
    (stream: uploadTask?.snapshotEvents,
      builder: (context,snapshot){
        if(snapshot.hasData){
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;

          return SizedBox(height: 50,
              child: Stack(
                  fit :StackFit.expand,
                  children: [
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: customBrown2,
                      color: Colors.green,
                    ),
                    Center(
                      child: Text(
                        '${(100*progress).roundToDouble()}%',
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ]
              ));

        }else{
          return
            const SizedBox(height:12);
        }
      });



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Video'),
        centerTitle: true,
        leading: BackButton(),
      ),
      body: Center(
        child: Column(
          children: [
              Expanded(
                  child:Icon(Icons.video_file)

                  ),

            SizedBox(height: 32,),
            ElevatedButton(
                onPressed: uploadToFirebase,
                child: Text('Upload Video')),
            SizedBox(height: 32,),
            buildProgress(),



          ],
        ),
      ),

    );


  }
}
