import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddCamera extends StatefulWidget {
  const AddCamera({super.key});

  @override
  _AddCameraState createState() => _AddCameraState();
}

class _AddCameraState extends State<AddCamera> {
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _modelController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> addCamera() async {
    var url = 'https://gp-prototype-back-end-api.azurewebsites.net/addCamera';
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        "model": _modelController.text,
        "location": _locationController.text,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          TextField(
            controller: _modelController,
            decoration: const InputDecoration(
              labelText: 'Model',
              hintText: 'Enter model',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _locationController,
            decoration: const InputDecoration(
              labelText: 'Location',
              hintText: 'Enter location',
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () {
              addCamera();
            },
            child: const Text('Add Camera'),
          ),
        ],
      ),
    );
  }
}
