import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddVehicleType extends StatefulWidget {
  const AddVehicleType({super.key});


  @override
  State<AddVehicleType> createState() => _AddVehicleTypeState();
}

class _AddVehicleTypeState extends State<AddVehicleType> {
  final TextEditingController _typeNameController = TextEditingController();

  @override
  void dispose() {
    _typeNameController.dispose();
    super.dispose();
  }

  Future<void> addVehicleType() async {
    var url = 'https://gp-prototype-back-end-api.azurewebsites.net/addVehicleType';
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        "typeName": _typeNameController.text,
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
            controller: _typeNameController,
            decoration: const InputDecoration(
              labelText: 'Type Name',
              hintText: 'Enter type name',
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () {
              addVehicleType();
            },
            child: const Text('Add Vehicle Type'),
          ),
        ],
      ),
    );
  }
}