import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HeightWidget extends StatefulWidget {
  final ValueChanged<double> onHeightChanged;

  const HeightWidget({super.key, required this.onHeightChanged});

  @override
  State<HeightWidget> createState() => _HeightWidgetState();
}

class _HeightWidgetState extends State<HeightWidget> {
  double _value = 170.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${_value.ceil()} cm',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          const Text(
            'Height',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 10),
          SfSlider.vertical(
            min: 0.0,
            max: 200.0,
            interval: 20,
            showTicks: true,
            showLabels: true,
            value: _value,
            onChanged: (newValue) {
              setState(() {
                _value = newValue;
                widget.onHeightChanged(_value);
              });
            },
          ),
        ],
      ),
    );
  }
}
