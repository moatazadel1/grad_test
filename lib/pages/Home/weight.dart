import 'package:flutter/material.dart';

class WeightWidget extends StatefulWidget {
  final ValueChanged<int> onWeightChanged;

  const WeightWidget({super.key, required this.onWeightChanged});

  @override
  State<WeightWidget> createState() => _WeightWidgetState();
}

class _WeightWidgetState extends State<WeightWidget> {
  int weight = 70;

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
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$weight",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          const Text(
            'Weight',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          WeightButton(
            onPressed: () => setState(() {
              weight++;
              widget.onWeightChanged(weight);
            }),
            icon: Icons.add,
            label: '   Add    ',
          ),
          WeightButton(
            onPressed: () => setState(() {
              weight--;
              widget.onWeightChanged(weight);
            }),
            icon: Icons.remove,
            label: 'Subtract',
          ),
        ],
      ),
    );
  }
}

class WeightButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  const WeightButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
