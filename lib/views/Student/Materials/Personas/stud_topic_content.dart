import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../app_styles.dart';
import '../../../../widgets/icon_and_text_widget.dart';
import '../Content/PdfReaderPage.dart';
import '../Content/Video_Pages/watchVideo.dart';

class stud_TopicContent extends StatefulWidget {
  final String Coursetitle;
  final String Topictitle;
  final String Persona_title;
  const stud_TopicContent({
    Key? key,
    required this.Coursetitle,
    required this.Topictitle,
    required this.Persona_title})
      : super(key: key);

  @override
  State<stud_TopicContent> createState() => _stud_TopicContent();
}

class _stud_TopicContent extends State<stud_TopicContent> {
  late String Topictitle;
  late String Personatitle;
  late String Coursetitle;

  void initState() {
    Coursetitle = widget.Coursetitle;
    Topictitle = widget.Topictitle;
    Personatitle = widget.Persona_title;
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
                                      (context) =>ReadingPage(
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
                            icon: Icons.menu_book_sharp,
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
        appBar: AppBar(
          actions: <Widget>[

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

