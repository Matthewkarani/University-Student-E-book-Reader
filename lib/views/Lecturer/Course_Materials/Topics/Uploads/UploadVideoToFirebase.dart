import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:treepy/views/Lecturer/Course_Materials/Topics/topics_content/lec_topic_content_page.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../../../../app_styles.dart';
import '../../../../../widgets/big_text.dart';
import 'UploadVideoToFirebase.dart';

class UploadVideoToFirebase extends StatefulWidget {
  final String filePath;
  final String Personatitle;
  final String Coursetitle;
  final String Topictitle;

  const UploadVideoToFirebase({
    Key? key,
    required this.filePath,
    required this.Personatitle,
    required this.Coursetitle,
    required this.Topictitle})
      : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<UploadVideoToFirebase> {

  UploadTask? uploadTask;
  late  String Personatitle;
  late  String Coursetitle;
  late  String Topictitle;

  final _videoDescriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final String video_description;

  @override
  void initState() {
    Personatitle= widget.Personatitle;
    Coursetitle= widget.Coursetitle;
    Topictitle= widget.Topictitle;
    super.initState();
  }
  @override
  void dispose() {
    _videoDescriptionController.dispose();
    super.dispose();
  }


  Future uploadToFirebase() async {
    var auth = FirebaseAuth.instance;
    var uid = auth.currentUser?.uid;
    var db = FirebaseFirestore.instance;
    String? Persona_key;
    video_description = _videoDescriptionController.text.trim();

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


    //create a variable to carry the video donload link
    var videoDownloadlink = <String, dynamic>{
      'video_link': urlDownload,
      'video_title' : video_description
    };

    //update persona Document
    db.collection('Topics')
        .doc(Coursetitle)
        .collection('My_Topics')
        .doc(Topictitle)
        .collection('Topic_summaryVideos')
        .doc()
        .set(videoDownloadlink);


    Navigator.pop;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Upload Successful"),
    ));




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

  Widget buildTitle() =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Align(alignment: Alignment.topLeft,
            child: BigText(text: 'Add Video Title',)),
      );
  Widget buildForm() => Form(
    key:_formKey,
    child:  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child:  CupertinoTextField(

        controller: _videoDescriptionController,
        maxLines: 1,)
      ,),

  );



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
            buildTitle(),
            SizedBox(height: 10,),
            buildForm(),
            SizedBox(height: 10,),
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
