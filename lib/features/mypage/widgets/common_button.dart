import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  CommonButton({
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
      child: Text(text),
    );
  }
}
