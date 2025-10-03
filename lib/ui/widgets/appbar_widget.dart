import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF29292D),
      elevation: 0,
      iconTheme: IconThemeData(
        size: 30,
        color: Colors.grey[600],
      ),
      leading: Icon(Icons.menu),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: Icon(Icons.settings),
        ),
      ],
    );
  }
}