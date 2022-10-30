import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:treepy/views/Lecturer/Course_Materials/topic_content_page.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../app_styles.dart';
import 'UploadVideoToFirebase.dart';

class UploadVideoToFirebase extends StatefulWidget {
  final String filePath;


  const UploadVideoToFirebase({Key? key, required this.filePath}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<UploadVideoToFirebase> {

  UploadTask? uploadTask;


  @override

  Future uploadToFirebase() async {

    final file = File(widget.filePath);
    final path = 'videos/${VideoPlayerController.file(file)}';

    final ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = ref.putFile(file);
    });

    //wait for the upload task to get completed
    final snapshot = await uploadTask!.whenComplete(() => {
      Navigator.pushNamed(context,
          '/totopicsContent'),
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Upload Successful"),
      ))
    });
    //On completion, get the download url.
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link : $urlDownload');

    //Store the files in firestore


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
        title: Text('Upload Notes'),
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
                child: Text('Upload File')),
            SizedBox(height: 32,),
            buildProgress(),



          ],
        ),
      ),

    );


  }
}
