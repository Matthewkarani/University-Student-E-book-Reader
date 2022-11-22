import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:treepy/app_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:treepy/views/Lecturer/Course_Materials/Personas/persona_details.dart';
import 'package:video_player/video_player.dart';
import '../../../../../widgets/icon_and_text_widget.dart';
import '../../../../Student/Materials/Content/PdfReaderPage.dart';
import '../../../../Student/Materials/Content/Video_Pages/watchVideo.dart';
import '../UpdateTopicPage.dart';
import '../Uploads/camera_page.dart';
import '../Uploads/uploadNotes.dart';
import '../topic_list_page.dart';
import 'lec_pdf_reader.dart';

class TopicContent extends StatefulWidget {
  final String Coursetitle;
  final String Topictitle;
  final String Persona_title;
  const TopicContent(
      {Key? key,
        required this.Topictitle,
    required this.Persona_title,
        required this.Coursetitle}) : super(key: key);

  @override
  State<TopicContent> createState() => _TopicContentState();
}

class _TopicContentState extends State<TopicContent> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late String notes_description;

  //Take video player as an argument
 /* Widget _VideoPlayer (VideoPlayer){
    return;

  }*/
  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

/* var h = MediaQuery(data: data, child: child)*/
  late String Topictitle;
  late String Personatitle;
  late String Coursetitle;
  @override
  void initState() {
    Coursetitle = widget.Coursetitle;
    Topictitle = widget.Topictitle;
    Personatitle = widget.Persona_title;
    _controller = VideoPlayerController.network(
      'https://firebasestorage.googleapis.com/v0/b/treepy-4cc05.appspot.com/o/videos%2FVideoPlayerController%23457c1(VideoPlayerValue(duration%3A%200%3A00%3A00.000000%2C%20size%3A%20Size(0.0%2C%200.0)%2C%20position%3A%200%3A00%3A00.000000%2C%20caption%3A%20Caption(number%3A%200%2C%20start%3A%200%3A00%3A00.000000%2C%20end%3A%200%3A00%3A00.000000%2C%20text%3A%20)%2C%20captionOffset%3A%200%3A00%3A00.000000%2C%20buffered%3A%20%5B%5D%2C%20isInitialized%3A%20false%2C%20isPlaying%3A%20false%2C%20isLooping%3A%20false%2C%20isBuffering%3A%20false%2C%20volume%3A%201.0%2C%20playbackSpeed%3A%201.0%2C%20errorDescription%3A%20null))?alt=media&token=805be328-ad8e-471a-991b-d74d50b8f7d6',
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    super.initState();
  }
  Future getNotes() async{
    final auth = FirebaseAuth.instance;
    var Firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await Firestore
        .collection('Topics')
        .doc(Coursetitle)
        .collection('My_Topics')
        .doc(Topictitle)
        .collection('Topic_notes')
        .get();

    return qn.docs;
  }

  Future getVideos() async{
    var Firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await Firestore
        .collection('Topics')
        .doc(Coursetitle)
        .collection('My_Topics')
        .doc(Topictitle)
        .collection('Topic_summaryVideos')
        .get();

    return qn.docs;

  }


  Future DeletePersona() async {
    final auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;

    await FirebaseFirestore.instance.collection("Persona").doc(uid)
        .collection('my_personas').doc(Personatitle).collection('Topics')
        .doc(Topictitle).delete().then(
          (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
  }

  GoToCameraPage(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=> CameraPage(
        Coursetitle:Coursetitle,
        Topictitle:Topictitle,
        Persona_title:Personatitle,))
    );
  }

  Future selectFile() async{
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=> uploadNotes(Personatitle:Personatitle ,
            Coursetitle : Coursetitle, Topictitle:Topictitle)));
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
                      MaterialPageRoute(builder: (context)=>TopicsList( Coursetitle: '', Personatitle: '',)));
                  DeletePersona();

                }
            )
          ],
        );
      },
    );
  }

  Widget buildNotes() =>
      FutureBuilder(
        future: getNotes(),
      builder: (BuildContext, snapshot){
          if(snapshot.hasData && snapshot.data != null){
            return SizedBox(
                height:250 ,
                child:  ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext,index){

              return ListTile(

                style: ListTileStyle.list,
                selectedTileColor: Colors.grey,

                minVerticalPadding: 10,


               /*Text(),*/
                title: IconAndTextWidget(
                  icon: Icons.menu_book_sharp,
                  text:snapshot.data[index].data()["notes_title"] ,
                  iconColor: customBrown2,),
                trailing: MaterialButton(
                  height: 30,
                  color: customBrown2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text('Open',style:
                  TextStyle(color: Colors.white),),
                  onPressed:(){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder:
                            (context) =>lecReadingPage(
                              pdfUrl: snapshot.data[index].data()["notes_link"],
                        ),)
                    );
                  },
                ),

              );

            }
            )
            );
          }else if(snapshot.data == null) {
            return
              Center(child: CircularProgressIndicator());

          } else{
            //Find a way of displaying this
            return Center(

                child:Text('No topics Created'));

          }







      });

  Widget buildVideos() =>
      FutureBuilder(
          future: getVideos(),
          builder: (BuildContext, snapshot){
            if(snapshot.hasData && snapshot.data != null){
              return SizedBox(
                  height:100 ,
                  child:  ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext,index){

                        return ListTile(

                          style: ListTileStyle.list,
                          selectedTileColor: Colors.grey,

                          minVerticalPadding: 10,


                          /*Text(),*/
                          title: IconAndTextWidget(
                            icon: Icons.video_collection_rounded,
                            text:snapshot.data[index].data()["video_title"] ,
                            iconColor: customBrown2,),
                          trailing: MaterialButton(
                            height: 30,
                            color: customBrown2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text('Open',style:
                            TextStyle(color: Colors.white),),
                            onPressed:(){


                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: video_page(
                                  video_url: snapshot.data[index].data()["video_link"],
                                ),
                                withNavBar: false, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation: PageTransitionAnimation.cupertino,
                              );

                            },
                          ),

                        );

                      }
                  )
              );
            }else if(snapshot.data == null) {
              return
                Center(child: CircularProgressIndicator());

            } else{
              //Find a way of displaying this
              return Center(

                  child:Text('No topics Created'));

            }







          });





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
        title: Text('Topic Content',
        ),
        centerTitle: true,
      ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),

                //Topic Title Label

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('Topic Name : '+ Topictitle ,style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 18
                  ),),
                ),
                SizedBox(height: 20,),
                //Edit Summary Videos row
                //title
                Text('Summary Video',style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 22
                ),),
                SizedBox(height: 20,),
                buildVideos(),

                SizedBox(height: 50,),

                //Edit summary notes

                  //title
                Text('Notes',style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 22
                ),),
                SizedBox(height: 20,),
                buildNotes(),

              /*  Padding(
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
                ),*/

                SizedBox(height: 200,),
                //Add New Topic Button


              ],
            ),
          ),

        )
    );
  }
}

// Original Video Layout Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: [
//                         Container(
//                           color: Colors.grey,
//                           height: 100,
//                           width: 200,
//                           child: Align(
//                               alignment: Alignment.center,
//                               child: Icon(Icons.play_arrow)),
//                         ),
//                         SizedBox(width: 30),
//                         Column(
//                           children: [
//                             MaterialButton(
//                               onPressed: (){},
//                               color: customBrown2,
//                               child: Text('Edit',
//                                   style: TextStyle(color: Colors.white)
//                               ),),
//                             SizedBox(height: 10,),
//                             MaterialButton(onPressed: (){},
//                               color: customBrown2,
//                               child: Text('Delete',
//                                 style: TextStyle(color: Colors.white),),),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
