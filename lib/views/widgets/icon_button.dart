import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final String number;
  final Function()? onPressed;
  final Color color;
  const CustomIconButton(
      {super.key,
      required this.icon,
      required this.number,
      required this.onPressed,
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        children: [
          IconButton(
            icon: Icon(
              icon,
              color: color,
              size: 30,
            ),
            onPressed: onPressed,
          ),
          Text(number)
        ],
      ),
    );
  }
}
