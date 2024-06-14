import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BMICala extends StatefulWidget {
  final double height;
  final int weight;

  BMICala(this.weight, this.height);

  @override
  State<BMICala> createState() => _BMICalaState();
}

class _BMICalaState extends State<BMICala> {
  @override
  Widget build(BuildContext context) {
    double bmi = widget.weight / (widget.height / 100 * widget.height / 100);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            bmi.toStringAsFixed(2),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          Text(
            'BMI',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
