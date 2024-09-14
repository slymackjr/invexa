import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/addItem');
            },
            child: const Text('Add Item'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/searchItem');
            },
            child: const Text('Search Item'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/itemList');
            },
            child: const Text('Item List'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/deleteItem');
            },
            child: const Text('Delete Item'),
          ),
        ],
      ),
    );
  }
}
