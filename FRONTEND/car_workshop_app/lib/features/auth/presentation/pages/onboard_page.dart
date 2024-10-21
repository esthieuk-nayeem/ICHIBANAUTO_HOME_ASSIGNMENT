import 'package:car_workshop_app/core/utils/services/local_storage_service.dart';
import 'package:car_workshop_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingData {
  const OnBoardingData(
      {required this.title, required this.assetUrl, required this.subTitle});

  final String assetUrl;
  final String title;
  final String subTitle;
}

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  final PageController onboardController = PageController();

  final List<OnBoardingData> data = const [
    OnBoardingData(
      title: 'Your Voice Matters',
      assetUrl: 'assets/on_boarding/vote.json',
      subTitle: 'Vote on news and make your voice heard.',
    ),
    OnBoardingData(
      title: 'Stay Anonymous',
      assetUrl: 'assets/on_boarding/anonymous.json',
      subTitle: 'Engage with news privately and securely.',
    ),
    OnBoardingData(
      title: 'Local Insights',
      assetUrl: 'assets/on_boarding/neighbourhood.json',
      subTitle: 'Stay updated on local news and events.',
    ),
  ];

  @override
  void dispose() {
    onboardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppStorage storage = AppStorage();
    return Scaffold(
      body: PageView.builder(
        controller: onboardController,
        itemCount: data.length,
        itemBuilder: (context, index) {
          OnBoardingData content = data[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 400,
                width: 400,
                child: Lottie.asset(content.assetUrl),
              ),
              const SizedBox(height: 30),
              Text(
                content.title,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
              ),
              Text(
                content.subTitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ],
          );
        },
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                onboardController.jumpToPage(2);
              },
              child: const Text("Skip"),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: onboardController,
                count: 3,
                effect: ExpandingDotsEffect(
                  activeDotColor: Colors.black,
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                int nextPage = onboardController.page!.toInt() + 1;
                if (nextPage < 3) {
                  onboardController.animateToPage(
                    nextPage,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  // Navigate to another screen or perform other actions
                  storage.onboardViewed.val = true;
                  Get.offAll(LoginScreen());
                }
              },
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
