import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/add_item_screen.dart';
import 'screens/search_item_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/addItem': (context) => const AddItemScreen(),
        '/searchItem': (context) => const SearchItemScreen(),
        // More routes for other screens like ItemList and DeleteItem can be added here
      },
    );
  }
}
