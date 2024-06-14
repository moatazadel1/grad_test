import 'package:flutter/material.dart';

class intro_widget extends StatefulWidget {


  @override
  State<intro_widget> createState() => _intro_widgetState();
}

class _intro_widgetState extends State<intro_widget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text(
            "Hi, Steven",
            style: TextStyle(color: Colors.black45, fontSize: 18),
          ),
          Text(
            "Smart Mood",
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 24,
                fontWeight: FontWeight.w800),
          ),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                child: Text(
                  "Get Start",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 18),
                ),
                padding: EdgeInsets.all(20),
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20)),
              ),
              Image(
                image: AssetImage(
                  'assets/images/sticker 1.png',
                ),
                height: 190,
                width: 210,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          //activite Status
          Text(
            "Activity Status",
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
