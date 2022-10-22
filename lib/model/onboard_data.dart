class OnBoarding {
  final String title;
  final String image;

  OnBoarding({
    required this.title,
    required this.image,
  });
}

List<OnBoarding> onboardingContents = [
  OnBoarding(
    title: 'Welcome to\n Treepy',
    image: 'assets/images/onboarding_image_1.png',
  ),
  OnBoarding(
    title: 'Develop better reading habits',
    image: 'assets/images/onboarding_image_2.png',
  ),
  OnBoarding(
    title: 'Embrace the Knowledge gaining journey',
    image: 'assets/images/onboarding_image_3.png',
  ),
  OnBoarding(
    title: 'Join a supportive community',
    image: 'assets/images/onboarding_image_4.png',
  ),
];
