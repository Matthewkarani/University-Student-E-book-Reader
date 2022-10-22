import 'package:flutter/material.dart';
import 'package:treepy/app_styles.dart';
import 'package:treepy/views/Lecturer/Course_Materials/topic_content_page.dart';

import 'addTopic.dart';

class TopicsList extends StatefulWidget {
  const TopicsList({Key? key}) : super(key: key);

  @override
  State<TopicsList> createState() => _TopicsList();
}

class _TopicsList extends State<TopicsList> {

  //VoidCallback void() is a function which takes no parameters
  // and returns no parameters.
  // In Flutter it is also true.
  // Sometimes we call it simply callback.
  void ToTopicPrimary() {

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>TopicContent()));

  }

  void ToAddTopicPage(){
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context)=> addTopic()));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:FloatingActionButton(
        child: Icon(Icons.add, semanticLabel: 'Add Topic',),
        onPressed: (){
          ToAddTopicPage();
        },
      ) ,
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Topic List',
          style: TextStyle(fontSize: 22
          ),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                trailing:MaterialButton(
          color: customBrown2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            child: Text('Open',style:
            TextStyle(color: Colors.white),),
            onPressed:ToTopicPrimary ,
          ),
                  title :Text('Topic 1',
                  style: TextStyle(fontSize: 22),),
                  onTap: (){},
              )

            ]
          ),
        ),


      )
    );
  }
}
