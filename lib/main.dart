import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treepy/model/rertrieve_persona_data.dart';
import 'package:treepy/views/Lecturer/Course_Materials/Personas/lec_persona_list.dart';
import 'package:treepy/views/Lecturer/Course_Materials/Topics/Uploads/uploadNotes.dart';
import 'package:treepy/views/Lecturer/Course_Materials/Topics/topics_content/topic_content_page.dart';
import 'package:treepy/views/Lecturer/Course_Materials/Topics/topic_list_page.dart';
import 'package:treepy/views/Student/Materials/Content/Video_Pages/watchVideo.dart';
import 'package:treepy/views/Student/Materials/Reports/ReadingReports.dart';
import 'package:treepy/views/Student/Home/mypersonas.dart';
import 'package:treepy/views/Student/Profile/stud_profile.dart';
import 'package:treepy/views/auth/main_page.dart';
import 'package:treepy/views/auth/register_page.dart';
import 'package:treepy/views/auth/signin_page.dart';
import 'package:treepy/views/onboarding_page.dart';
import 'package:treepy/widgets/Video_Player_Widget.dart';
import 'Notifiers/Persona_Notifier.dart';
import 'app_styles.dart';
import 'views/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

bool? seenOnboard;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // to load onboarding screen for the first time only
  SharedPreferences pref = await SharedPreferences.getInstance();
  seenOnboard = pref.getBool('seenOnboard') ?? false;// if null set to false

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );

  /*final emulatorHost =
  (!kIsWeb && defaultTargetPlatform == TargetPlatform.android)
      ? '10.0.2.2'
      : 'localhost';

  await FirebaseStorage.instance.useStorageEmulator(emulatorHost, 9199);*/

  runApp( MyApp());



}


class MyApp extends StatelessWidget {

  const MyApp({
    Key? key,

  }) : super (key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {

          // When navigating to the "/second" route, build the SecondScreen widget.

        },
      debugShowCheckedModeBanner: false,
      title: 'Treepy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary:  customBrown,
          secondary: customBrown2,
        ),

    appBarTheme: AppBarTheme(color: customBrown),
        textTheme: GoogleFonts.manropeTextTheme(
          Theme.of(context).textTheme,

        ),


      ),
        home:
        //studPersonas()//mypersonas()//TopicContent()//mypersonas()
      // addTopic()
      // ReadingPage()
      //AddNotes()
        //RegisterPage(showLoginPage: () {  },)
        //LecsHome()
      //createPersona()
      //StdLanding()
       /* VideoPlayerScreen()*///video_page()
       // uploadNotes(Personatitle: '',)
      seenOnboard == true ? MainPage() : OnBoardingPage()
     );
  }
}



