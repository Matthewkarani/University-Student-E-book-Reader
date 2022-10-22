import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:treepy/views/Lecturer/Course_Materials/topic_content_page.dart';
import 'package:video_player/video_player.dart';

import 'UploadVideoToFirebase.dart';

class VideoPage extends StatefulWidget {
  final String filePath;


  const VideoPage({Key? key, required this.filePath}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  //add a new _videoPlayerController variable.
  late VideoPlayerController _videoPlayerController;
  UploadTask? uploadTask;
  @override
  //dispose the video controller once the videoController State gets disposed.
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
  // Create a new VideoPlayerController from the file path that
    // we passed to this widget.
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));


    //Initialize the VideoPlayerController before we can start it.
    await _videoPlayerController.initialize();
    //To play the video over and over again, we enable looping.
    await _videoPlayerController.setLooping(true);
    //Play the video.
    await _videoPlayerController.play();
    await _videoPlayerController.dispose();
  }
// Create a storage reference from our app
  final storageRef = FirebaseStorage.instance.ref();

  Future uploadToStorage() async {
    final file = File(widget.filePath);
    final route = MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => UploadVideoToFirebase(filePath: file.path),
    );
    dispose();
    Navigator.push(context, route);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //AppBar to accept or dismiss the video
      appBar: AppBar(
        title: const Text('Preview'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed:uploadToStorage,
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _initVideoPlayer(),
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return VideoPlayer(_videoPlayerController);
          }
        },
      ),
    );
  }
}

/* try {
      final DateTime now = DateTime.now();
      final int millSeconds = now.millisecondsSinceEpoch;
      final String month = now.month.toString();
      final String date = now.day.toString();
      final String storageId = (millSeconds.toString() + uid);
      final String today = ('$month-$date');

      final file =  await ImagePicker.pickVideo(source: ImageSource.gallery);

      StorageReference ref = FirebaseStorage.instance.ref().child("video").child(today).child(storageId);
      StorageUploadTask uploadTask = ref.putFile(file, StorageMetadata(contentType: 'video/mp4'));

    Uri downloadUrl = (await uploadTask.future).downloadUrl;

    final String url = downloadUrl.toString();

    print(url);

    } catch (error) {
    print(error);
    }

  } */

