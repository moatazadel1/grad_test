import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class Spo2 extends StatefulWidget {
  const Spo2({super.key});

  @override
  State<Spo2> createState() => _Spo2State();
}

class _Spo2State extends State<Spo2> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      width: width * .3,
      height: height * .2,
      child: Column(
        children: [
          const Text(
            '100%',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
          ),
          const Text(
            'Spo2',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          SimpleCircularProgressBar(
              animationDuration: 10,
              startAngle: -180,
              onGetText: (double value) {
                TextStyle centerTextStyle = TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color:
                      Theme.of(context).primaryColor.withOpacity(value * 0.01),
                );

                return Text(
                  '${value.toInt()}',
                  style: centerTextStyle,
                );
              }),
        ],
      ),
    );
  }
}
