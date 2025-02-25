import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onTap; // Changed to `onTap` for consistency
  final String text;

  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30), // Matches the button's shape
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
              vertical: 12, horizontal: 15), // Combined padding
          decoration: ShapeDecoration(
            color: Colors.blue, // Added background color for visibility
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
