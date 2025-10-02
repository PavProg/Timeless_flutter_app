import 'package:flutter/material.dart';
import '../canvas/home_canvas.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212226),
      appBar: PreferredSize(preferredSize: Size.fromHeight(56), child: AppBarWidget()),
      body: Center(
        child: HomeCanvas(),
      ),
      bottomNavigationBar: BottomNavbar(selected: 2),
    );
  }
}