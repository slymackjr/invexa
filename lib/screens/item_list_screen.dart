import 'dart:io';

import 'package:flutter/material.dart';

import '../services/database_service.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  List<Map<String, dynamic>> _items = [];

  Future<void> _loadItems() async {
    final items = await DatabaseService().getItems();
    setState(() {
      _items = items;
    });
  }

  Future<void> _deleteItem(int id) async {
    await DatabaseService().deleteItem(id);
    _loadItems();  // Reload the list after deletion
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item List'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return ListTile(
            leading: item['image'].isNotEmpty
                ? Image.file(File(item['image']), height: 50)
                : const Icon(Icons.image_not_supported),
            title: Text(item['name']),
            subtitle: Text('Price: ${item['price']} - Item Number: ${item['itemNumber']}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteItem(item['id']),
            ),
            onTap: () {
              // Handle item edit here (navigate to edit screen)
            },
          );
        },
      ),
    );
  }
}
