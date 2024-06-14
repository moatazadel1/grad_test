import 'package:flutter/material.dart';

class IntroWidget extends StatelessWidget {
  String title;
  String image;
  String desc;

  IntroWidget(this.title, this.image, this.desc, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary, fontSize: 18),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 50, left: 20),
          child: Text(
            desc,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            alignment: Alignment.bottomRight,
            child: Image(
              image: AssetImage(image),
              height: 190,
              width: 210,
            )),
      ],
    );
  }
}
