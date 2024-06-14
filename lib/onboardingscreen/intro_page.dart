import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroOnboarding extends StatelessWidget {
  final String img;
  final String title;
  final bool buttun;

  const IntroOnboarding(
      {super.key, required this.img, required this.title, this.buttun = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(
            height: 155,
          ),
          Center(
            child: Container(
              width: 320,
              height: 310,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    img,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
