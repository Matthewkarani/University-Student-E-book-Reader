import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:treepy/views/Lecturer/Course_Materials/Topics/topics_content/topic_content_page.dart';

import '../../../../../app_styles.dart';
import '../../../../../widgets/big_text.dart';


class uploadNotes extends StatefulWidget {
  final String Personatitle;
  final String Coursetitle;
  final String Topictitle;
  const uploadNotes({Key? key, required this.Personatitle, required this.Coursetitle,
    required this.Topictitle, }) : super(key: key);

  @override
  State<uploadNotes> createState() => _uploadNotesState();
}

class _uploadNotesState extends State<uploadNotes> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  late String Personatitle;
  late String Coursetitle;
  late String Topictitle;

  final _notesDescriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late final String notes_description;

  @override
  void dispose() {
    _notesDescriptionController.dispose();
    super.dispose();
  }



  @override
  void initState() {
    Coursetitle = widget.Coursetitle;
    Personatitle = widget.Personatitle;
    Topictitle = widget.Topictitle;
    super.initState();
  }

  Future selectFile() async{
    final result = await FilePicker.platform.pickFiles(type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if(result == null)  return ;

    setState(() {
      pickedFile = result.files.first;
    });
  }




  Future uploadFile() async {
    notes_description = _notesDescriptionController.text.trim();
    var auth = FirebaseAuth.instance;
    var uid = auth.currentUser?.uid;
    var db = FirebaseFirestore.instance;
    String? Persona_key;

    Persona_key = Personatitle;
    //Define where you want to store the file in firebase
    // (we include the name of the picked file.
    final path = 'files/${pickedFile!.name}';
    //simply Convert the picked file to a file object
    final file = File(pickedFile!.path!);

    //Upload the file to firebase using the firebase storage package
    final ref = FirebaseStorage.instance.ref().child(path);


    setState(() {
      uploadTask = ref.putFile(file);
    });

    //wait for the upload task to get completed
    final snapshot = await uploadTask?.whenComplete(() => {




    }

      //On completion, get the download url.


    );
    final urlDownload = await snapshot?.ref.getDownloadURL();

    //create a variable to carry the video donload link
    var notesDownloadlink = <String, dynamic>{
      'notes_title': notes_description,

      'notes_link': urlDownload
    };

    print('This is the notes persona download link ${notesDownloadlink}');
    //update persona Document
    db.collection('Topics')
        .doc(Coursetitle)
        .collection('My_Topics')
        .doc(Topictitle)
        .collection('Topic_notes')
        .doc()
        .set(notesDownloadlink);

    print('notes saved');
    print(Coursetitle);
    print(Topictitle);



    //google how to implement routes
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Upload Successful"),
    ));
    print('Download Link : $urlDownload');



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

  Widget buildForm() => Form(
    key:_formKey,
    child:  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child:  CupertinoTextField(

        controller: _notesDescriptionController,
        maxLines: 1,)
      ,),

  );

  Widget buildTitle() =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Align(alignment: Alignment.topLeft,
        child: BigText(text: 'Add Notes Title',)),
      );




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Notes'),
        centerTitle: true,
        leading: BackButton(),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if(pickedFile != null)
                SizedBox(
                  height: 180,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 125,
                        width: 125,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              //google how to display a preview of a video
                              Image.asset('assets/images/pdf_Icon.png',),
                              SizedBox(height: 5,),
                              Text(pickedFile!.name),
                            ],
                          ),
                        )
                         ,),
                    )
                ),
              SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: selectFile,
                  child: Text('Select File')),
              SizedBox(height: 32,),

              //Notes Title Description

              buildTitle(),
              SizedBox(height: 10,),
              //Add Notes Title Form field
             buildForm(),

              SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: uploadFile,
                  child: Text('Upload File')),
              SizedBox(height: 32,),
              buildProgress(),



            ],
          ),
        ),
      ),

    );


  }
}


