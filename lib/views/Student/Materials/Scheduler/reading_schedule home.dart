
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../api/notifications.dart';
import '../../../../app_styles.dart';
import '../../../../util/utilities.dart';
import '../../../../widgets/icon_and_text_widget.dart';
import '../../../../widgets/widgets.dart';
import '../../../Lecturer/Course_Materials/Topics/topics_content/lec_pdf_reader.dart';
import 'createReadingSchedule.dart';

class ReadingScheduleHome extends StatefulWidget {
  const ReadingScheduleHome({Key? key}) : super(key: key);

  @override
  State<ReadingScheduleHome> createState() => _ReadingScheduleHome();
}

class _ReadingScheduleHome extends State<ReadingScheduleHome> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then(
          (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text('Allow Notifications'),
                  content: Text('Our app would like to send you notifications'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Don\'t Allow',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          AwesomeNotifications()
                              .requestPermissionToSendNotifications()
                              .then((_) => Navigator.pop(context)),
                      child: Text(
                        'Allow',
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
          );
        }
      },
    );
  }
  Future getReadingSchedules() async{
    var Firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await Firestore
        .collection('Notifications')
        .get();

    return qn.docs;

  }

  Widget buildReadingSchedules() =>
      FutureBuilder(
          future: getReadingSchedules(),
          builder: (BuildContext, snapshot){
            if(snapshot.hasData && snapshot.data != null){
              return SizedBox(
                  height:400,
                  child:  ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext,index){
                        return ListTile(
                          style: ListTileStyle.list,
                          selectedTileColor: Colors.grey,
                          minVerticalPadding: 10,
                          subtitle: Text('Scheduled for every :'
                              +'${snapshot.data[index].data()["selectedDay"]}'
                              + ' at ' + '${snapshot.data[index].data()["timeOfDay"]}'),
                          title: IconAndTextWidget(
                            icon: Icons.alarm,
                            text:'${snapshot.data[index].data()["Schedule Title"]}',

                            iconColor: customBrown2,),
                          // trailing: MaterialButton(
                          //   height: 30,
                          //   color: customBrown2,
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(20)), onPressed: () {  }, ,),

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
            }});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
      FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
          MaterialPageRoute(
              builder: (context)=>
          CreateReadingSchedule()));
        },
        child: Icon(Icons.add),),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Align(
              alignment:Alignment.topCenter,
              child: Text('My reading Schedules'
                ,style: TextStyle(
                    fontSize: 22,
                    decoration: TextDecoration.underline),)),
          SizedBox(height: 10,),
          buildReadingSchedules()

          //


        ],
      ),
    );
  }
}


