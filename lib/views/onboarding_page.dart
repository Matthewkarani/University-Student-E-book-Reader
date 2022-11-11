import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treepy/main.dart';
import 'package:treepy/views/auth/signin_page.dart';

import '../app_styles.dart';
import '../model/onboard_data.dart';
import '../size_configs.dart';
import '../widgets/my_text_button.dart';
import '../widgets/onboard_nav_btn.dart';
import 'pages.dart';
import '../widgets/widgets.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentPage = 0;

  PageController _pageController = PageController(initialPage: 0);

  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
        margin: EdgeInsets.only(right: 5),
        duration: Duration(milliseconds: 400),
        height: 12,
        width: 12,
        decoration: BoxDecoration(
          color: currentPage == index ? Colors.brown : Colors.amber,
          shape: BoxShape.circle,
        )
    );
  }
  Future setSeenonBoard() async{
    var seenOnboard;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //to set seen onOnboard to true, when running onboard for the first time.
    seenOnboard = await prefs.setBool('seenOnboard', true);
  }


  @override
  void initState() {
    super.initState();
    setSeenonBoard();
  }

  @override
  Widget build(BuildContext context) {
    //Initialize size config
    SizeConfig().init(context);
    double SizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
                flex: 9,
                child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: onboardingContents.length,
                    itemBuilder: (BuildContext context, int index) => Column(
                          children: [
                            SizedBox(
                              height: sizeV * 5,
                            ),
                            Text(onboardingContents[index].title,
                                style: kTitle,
                                textAlign: TextAlign.center),
                            SizedBox(
                              height: sizeV * 5,
                            ),
                            Container(
                              height: sizeV * 50,
                              child: Image.asset(
                                onboardingContents[index].image,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(
                              height: sizeV * 5,
                            ),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'WE CAN ',
                                      style: TextStyle(color: Colors.purple)),
                                  TextSpan(
                                      text: 'HELP YOU ',
                                      style: TextStyle(color: Colors.amber)),
                                  TextSpan(
                                      text: 'TO BE A BETTER ',
                                      style: TextStyle(color: Colors.blue)),
                                  TextSpan(
                                      text: 'VERSION OF ',
                                      style: TextStyle(color: Colors.red)),
                                  TextSpan(
                                      text: 'YOURSELF',
                                      style: TextStyle(color: Colors.brown)),
                                ])),
                            SizedBox(
                              height: sizeV * 5,
                            ),
                          ],
                        ))),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    currentPage == onboardingContents.length - 1
                        ? MyTextButton(
                      buttonName: 'Get Started',
                    onPressed: (){
                      seenOnboard();
                        Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context)=>
                            LoginPage(showRegisterPage: () {  },)),
                        );
                    },
                    bgColor: kPrimaryColor,
                    )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Row(
                                    children: [
                                      OnBoardNavBtn(
                                        name: 'Skip',
                                        onPressed: () {
                                          seenOnboard();
                                          Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder:
                                                (context)=>LoginPage(showRegisterPage: () {  },)));
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                children: List.generate(
                                  onboardingContents.length,
                                  (index) => dotIndicator(index),
                                ),
                              ),
                              OnBoardNavBtn(
                                name: 'Next',
                                onPressed: () {
                                  _pageController.nextPage(
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                },
                              ),
                            ],
                          ),
                  ],
                )
            )
          ],
        )
        )
    );
  }


  void seenOnboard() async{
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();// Save an boolean value to 'repeat' key.
    await prefs.setBool('seenOnBoard', true);

  }
}



