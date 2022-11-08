import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:treepy/views/Lecturer/Course_Materials/Topics/Uploads/video%20page.dart';
import 'package:treepy/views/Lecturer/Course_Materials/Topics/topics_content/topic_content_page.dart';



class CameraPage extends StatefulWidget {
  final String Persona_title;
  final String Coursetitle;
  final String Topictitle;
  const CameraPage({Key? key,
    required this.Persona_title,
    required this.Coursetitle,
    required this.Topictitle,}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool _isLoading = true;
  bool _isRecording = false;
  late CameraController _cameraController;
  late String Personatitle;
  late String Coursetitle;
  late String Topictitle;


  backToTopics(){
    Navigator.pushNamed(context,
        '/totopicsContent');
  }

  @override
  void initState() {
    _initCamera();
    Personatitle = widget.Persona_title;
    Coursetitle = widget.Coursetitle;
    Topictitle = widget.Topictitle;
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  _initCamera() async {
    //add button which allows you to control which camera you are using
    //do research on how
    final cameras = await availableCameras();
    final front = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
    _cameraController = CameraController(front, ResolutionPreset.max);
    await _cameraController.initialize();
    setState(() => _isLoading = false);
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      setState(() => _isRecording = false);
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => VideoPage(
            Topictitle:Topictitle,
            Coursetitle:Coursetitle,
            filePath: file.path,
            Personatitle:Personatitle),
      );
      Navigator.push(context, route);
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return SafeArea(
        child: Container(
          color: Colors.white,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Record Summary Video'),
          centerTitle: true,
          leading: BackButton(),
        ),
        body: SafeArea(
          child: Center(
            child: Stack(
              fit: StackFit.expand,
              children: [
                CameraPreview(_cameraController),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FloatingActionButton(
                      backgroundColor: Colors.red,
                      child: Icon(_isRecording ? Icons.stop : Icons.circle),
                      onPressed: () => _recordVideo(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}