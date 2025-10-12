import 'package:flutter/material.dart';

class SimpleDialogItem extends StatelessWidget {
  final String iconPath;
  final String label;

  const SimpleDialogItem(
      this.iconPath,
      this.label, {
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Image.asset(iconPath, width: 28, height: 28, color: Color(0xFF4B4B4D)),
          const SizedBox(width: 14),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFFA1A1A1),
            )
          ),
        ],
      ),
    );
  }
}