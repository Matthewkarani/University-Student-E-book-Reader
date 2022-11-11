

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treepy/views/Student/Materials/Personas/stud_persona_list.dart';
import 'package:treepy/views/auth/main_page.dart';
import 'package:treepy/views/onboarding_page.dart';
import 'app_styles.dart';
import 'views/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:awesome_notifications/awesome_notifications.dart';


bool? seenOnboard;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // to load onboarding screen for the first time only
  SharedPreferences pref = await SharedPreferences.getInstance();
  seenOnboard = pref.getBool('seenOnboard') ?? false;// if null set to false

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,


  );

  await AwesomeNotifications().initialize(
       null,
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic Notifications',
            channelDescription: 'Notification tests as alerts',
            playSound: true,
            onlyAlertOnce: true,
            //groupAlertBehavior: GroupAlertBehavior.Children,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
            defaultColor: customBrown2,
            channelShowBadge: true,
            ledColor: Colors.deepPurple)
      ],
      debug: true);



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
          '/toStud_persona_list' : (context) => studPersonas()
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
        home://CreateReadingSchedule()
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



