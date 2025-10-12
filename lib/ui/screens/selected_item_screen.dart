import 'package:flutter/material.dart';
import '../canvas/selected_item_canvas.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/bottom_navbar.dart';

class SelectedItemScreen extends StatelessWidget {
  final String label;

  const SelectedItemScreen({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212226),
      appBar: AppBarWidget(title: label),
      body: const SelectedItemCanvas(),
      bottomNavigationBar: const BottomNavbar(selected: 0),
    );
  }
}
