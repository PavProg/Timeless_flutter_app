import 'package:flutter/material.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/bottom_navbar.dart';
import '../canvas/cart_canvas.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212226),
      appBar: AppBarWidget(),
      body: const CartCanvas(),
      bottomNavigationBar: const BottomNavbar(selected: 3),
    );
  }

}