import 'package:flutter/material.dart';

class AgeWidget extends StatefulWidget {
  final Function(int) onAgeChanged;

  const AgeWidget({super.key, required this.onAgeChanged});

  @override
  State<AgeWidget> createState() => _AgeWidgetState();
}

class _AgeWidgetState extends State<AgeWidget> {
  int age = 0;

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
            "$age",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          const Text(
            'Age',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          WeightButton(
            onPressed: () {
              setState(() {
                age++;
              });
              widget.onAgeChanged(age);
            },
            icon: Icons.add,
            label: '   Add    ',
          ),
          WeightButton(
            onPressed: () {
              setState(() {
                age--;
              });
              widget.onAgeChanged(age);
            },
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
