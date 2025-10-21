import 'package:flutter/material.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/cart_screen.dart';
import 'ui/screens/profile_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TIMILESS APP',
      theme: ThemeData(
        fontFamily: 'Jura',
      ),
      home: HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/cart': (context) => const CartScreen(),
        '/profile': (context) => const ProfileScreen(),
        // Другие маршруты
      },
    );
  }
}