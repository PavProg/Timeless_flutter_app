import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF29292D),
      elevation: 0,
      leading: Icon(Icons.menu, color: Colors.grey[600]),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: Icon(Icons.settings, color: Colors.grey[600]),
        ),
      ],
    );
  }
}