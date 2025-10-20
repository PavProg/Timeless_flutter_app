import 'package:flutter/material.dart';
import 'package:time_multiapplication_byflutter/ui/screens/cart_screen.dart';
import '../screens/profile_screen.dart';

class BottomNavbar extends StatelessWidget {
  final int selected;

  const BottomNavbar({super.key, this.selected = 0});

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
          _buildNavItem('AppMaterial/NewsIcon.png', 0, context),
          _buildNavItem('AppMaterial/ArchiveIcon.png', 1, context),
          _buildNavItem('AppMaterial/ProfileIcon.png', 2, context),
          _buildNavItem('AppMaterial/CartIcon.png', 3, context),
        ],
      ),
    );  // Container
  }

  Widget _buildNavItem(String iconPath, int index, BuildContext context) {
    bool isSelected = selected == index;
    return GestureDetector(
      onTap: () {
        _handleNavigation(context, index);
      },

      child: Container(
        padding: EdgeInsets.all(12),
        child: Image.asset(
          iconPath,
          width: 30,
          height: 30,
          color: isSelected ? Color(0xFFD07B59) : Colors.grey[600],
        ),
      ),
    );
  }

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Navigator.of(context).popUntil((route) => route.isFirst);
        print('News pressed');
        break;
      case 1:
        print('button tracking pressed');
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
      case 3:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CartScreen()),
        );
        break;
    }
  }

}