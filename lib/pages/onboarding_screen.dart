import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:uts_mobprog_kelompok_2/components/color.dart';
import 'package:uts_mobprog_kelompok_2/components/onboarding_items.dart';
import 'package:uts_mobprog_kelompok_2/pages/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color9,
      bottomSheet: Container(
        color: color9,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip Button
                  TextButton(
                      onPressed: () => pageController
                          .jumpToPage(controller.items.length - 1),
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                            fontSize: 18,
                            color: color1,
                            fontWeight: FontWeight.w600),
                      )),
                  // Indicator
                  SmoothPageIndicator(
                    controller: pageController,
                    count: controller.items.length,
                    onDotClicked: (index) => pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn),
                    effect: const WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: color1,
                    ),
                  ),
                  // Next Button
                  TextButton(
                    onPressed: () => pageController.nextPage(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn),
                    child: const Text(
                      "Next",
                      style: TextStyle(
                          fontSize: 18,
                          color: color1,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: PageView.builder(
                onPageChanged: (index) => setState(
                    () => isLastPage = controller.items.length - 1 == index),
                itemCount: controller.items.length,
                controller: pageController,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(controller.items[index].image),
                      const SizedBox(height: 15),
                      Text(
                        controller.items[index].title,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: color2),
                      ),
                      const SizedBox(height: 15),
                      Text(controller.items[index].descriptions,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                          textAlign: TextAlign.center),
                    ],
                  );
                }),
          ),
          Positioned(
            top: 35,
            left: 10,
            child: Row(
              children: [
                Image.asset(
                  'images/utiwi-logo.png',
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Utiwi',
                  style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold, color: color1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getStarted() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color1,
      ),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: TextButton(
        onPressed: () async {
          final pres = await SharedPreferences.getInstance();
          pres.setBool("onboarding", true);

          if (!mounted) return;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
        child: const Text(
          "Get started",
          style: TextStyle(color: color9, fontSize: 20),
        ),
      ),
    );
  }
}
