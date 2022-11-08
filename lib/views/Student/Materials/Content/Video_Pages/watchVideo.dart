import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:treepy/views/Student/Materials/Content/Video_Pages/_ControlsOverlay.dart';

class video_page extends StatefulWidget {
  final String video_url;
  const video_page({
    Key? key,
    required this.video_url})
      : super(key: key);

  @override
  State<video_page> createState() => _video_pageState();
}

class _video_pageState extends State<video_page> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  late String video_url;

  @override
  void initState() {
    video_url = widget.video_url;
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      video_url  );
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary Video'),

      ),
      extendBodyBehindAppBar: false,
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: Stack(
        fit:StackFit.expand,
        children:[

          FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the VideoPlayerController has finished initialization, use
              // the data it provides to limit the aspect ratio of the video.
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                // Use the VideoPlayer widget to display the video.
                child: VideoPlayer(_controller),
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              // If the VideoPlayerController is still initializing, show a
              // loading spinner.
              return const Center(
                child: Text('No Network Connection'),
              );
            } else {
              // If the VideoPlayerController is still initializing, show a
              // loading spinner.
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),

   Padding(
     padding: const EdgeInsets.all(8.0),
     child: Align(
       alignment: Alignment.bottomCenter,
       child: FloatingActionButton(
        onPressed: () {
        // Wrap the play or pause in a call to `setState`. This ensures the
        // correct icon is shown.
        setState(() {
        // If the video is playing, pause it.
        if (_controller.value.isPlaying) {
        _controller.pause();
        } else {
        // If the video is paused, play it.
        _controller.play();
        }
        });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
        _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
        ),
     ),
   ),


        ]
      )
    );
  }
}