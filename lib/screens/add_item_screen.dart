import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'dart:io';
import '../services/database_service.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _expireDateController = TextEditingController();
  final _itemNumberController = TextEditingController();
  String _barcode = '';
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _scanBarcode() async {
    var result = await BarcodeScanner.scan();
    setState(() {
      _barcode = result.rawContent;
    });
  }

  Future<void> _saveItem() async {
    Map<String, dynamic> item = {
      'name': _nameController.text,
      'expireDate': _expireDateController.text.isNotEmpty ? _expireDateController.text : null,  // Optional
      'price': double.tryParse(_priceController.text) ?? 0.0,
      'itemNumber': int.tryParse(_itemNumberController.text) ?? 0,
      'image': _image?.path ?? '',
    };

    await DatabaseService().insertItem(item);
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Item Name'),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _expireDateController,
              decoration: const InputDecoration(labelText: 'Expire Date'),
            ),
            TextField(
              controller: _itemNumberController,
              decoration: const InputDecoration(labelText: 'Item Number'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _scanBarcode,
              child: const Text('Scan Barcode'),
            ),
            Text(_barcode.isNotEmpty ? 'Barcode: $_barcode' : 'No Barcode Scanned'),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Item Image'),
            ),
            _image != null ? Image.file(_image!, height: 100) : const Text('No Image Selected'),
            ElevatedButton(
              onPressed: _saveItem,
              child: const Text('Save Item'),
            ),
          ],
        ),
      ),
    );
  }
}
