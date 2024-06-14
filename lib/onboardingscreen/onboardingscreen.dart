import 'package:flutter/material.dart';
import 'package:new_app/auth/login/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../auth/SignUp/sign_up_screen.dart';
import 'intro_page.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "onboard";

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/splash Screen.png"),
              fit: BoxFit.fill)),
      child: Scaffold(
        bottomNavigationBar: !onLastPage
            ? Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.elasticIn);
                      },
                      label: const Text(
                        "Next",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(Login.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff0076CA),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10)),
                    child: const Text(
                      "Login Now",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(SignUpScreen.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10)),
                    child: const Text(
                      "Sign up ",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                ],
              ),
        body: Stack(
          children: [
            const Text(
              "skip",
              style: TextStyle(color: Colors.white),
            ),
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  onLastPage = (index == 2);
                });
              },
              children: const [
                IntroOnboarding(
                  img: "assets/images/Onboarding1.gif",
                  title: "Get ready to experience our smart bracelet",
                ),
                IntroOnboarding(
                    img: "assets/images/Onboarding2.gif",
                    title: "Our bracelet detects emotions in real-time "),
                IntroOnboarding(
                  img: "assets/images/Onboarding3.gif",
                  title:
                      "Stay connected with your child's well-being effortlessly",
                )
                // Container(color: Colors.blue),
                //  Container(color: Colors.red),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.sizeOf(context).height * 0.15,
                ),
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                    dotColor: Color(0xff5D9CEC),
                    activeDotColor: Color(0xff0076CA),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  // padding: EdgeInsets.zero,
                  // padding: EdgeInsets.only(
                  //     top: MediaQuery.sizeOf(context).height * 0.92),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //Text("Skip" ,),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 100,
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
