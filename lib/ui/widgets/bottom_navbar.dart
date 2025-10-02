import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final int selected;

  BottomNavbar({this.selected = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Color(0xFF212226),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),  //BoxShadow
        ],  // BoxShadow
      ),  // BoxDecoration
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem('AppMaterial/NewsIcon.png', 0),
          _buildNavItem('AppMaterial/ArchiveIcon.png', 1),
          _buildNavItem('AppMaterial/ProfileIcon.png', 2),
          _buildNavItem('AppMaterial/CartIcon.png', 3),
        ],
      ),
    );  // Container
  }

  Widget _buildNavItem(String iconPath, int index) {
    bool isSelected = selected == index;
    return Container(
      padding: EdgeInsets.all(12),
      child: Image.asset(
        iconPath,
        width: 30,
        height: 30,
        color: isSelected ? Color(0xFFD8B08C) : Colors.grey[600],
      ),
    );
  }
}