import 'package:flutter/material.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/cart_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TIMILESS APP',
      theme: ThemeData.dark(),
      home: HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/cart': (context) => const CartScreen(),
        // Другие маршруты
      },
    );
  }
}