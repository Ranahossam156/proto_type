import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddRoad extends StatefulWidget {
  const AddRoad({super.key});


  @override
  State<AddRoad> createState() => _AddRoadState();
}

class _AddRoadState extends State<AddRoad> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _directionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _directionController.dispose();
    super.dispose();
  }

  Future<void> addRoad() async {
    var url = 'https://gp-prototype-back-end-api.azurewebsites.net/addRoad';
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        "name": _nameController.text,
        "direction": _directionController.text == 'true',
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
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'Enter name',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _directionController,
            decoration: const InputDecoration(
              labelText: 'Direction',
              hintText: 'Enter direction (true/false)',
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () {
              addRoad();
            },
            child: const Text('Add Road'),
          ),
        ],
      ),
    );
  }
}