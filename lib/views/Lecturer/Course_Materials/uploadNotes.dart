import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:treepy/views/Lecturer/Course_Materials/topic_content_page.dart';

import '../../../app_styles.dart';

class uploadNotes extends StatefulWidget {
  const uploadNotes({Key? key}) : super(key: key);

  @override
  State<uploadNotes> createState() => _uploadNotesState();
}

class _uploadNotesState extends State<uploadNotes> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectFile() async{
    final result = await FilePicker.platform.pickFiles(type: FileType.custom,
      allowedExtensions: ['pdf','docx'],
    );

    if(result == null)  return ;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async{
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
    final snapshot = await uploadTask!.whenComplete(() => {
    Navigator.pushNamed(context,
        '/totopicsContent')
      ,
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
            if(pickedFile != null)
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: 200,
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
            ElevatedButton(
                onPressed: uploadFile,
                child: Text('Upload File')),
            SizedBox(height: 32,),
            buildProgress(),



          ],
        ),
      ),

    );


  }
}
