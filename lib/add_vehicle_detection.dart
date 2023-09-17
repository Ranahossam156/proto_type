import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddVehicleDetections extends StatefulWidget {
  const AddVehicleDetections({super.key});


  @override
  State<AddVehicleDetections> createState() => _AddVehicleDetectionsState();
}

class _AddVehicleDetectionsState extends State<AddVehicleDetections> {
  final TextEditingController _vehicleTypeController = TextEditingController();
  final TextEditingController _roadIdController = TextEditingController();
  final TextEditingController _cameraIdController = TextEditingController();

  @override
  void dispose() {
    _vehicleTypeController.dispose();
    _roadIdController.dispose();
    _cameraIdController.dispose();
    super.dispose();
  }

  Future<void> addVehicleDetection() async {
    var url = 'https://gp-prototype-back-end-api.azurewebsites.net/addVehicleDetection';
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        "vehicleType": _vehicleTypeController.text,
        "roadId": _roadIdController.text,
        "cameraId": _cameraIdController.text,
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
            controller: _vehicleTypeController,
            decoration: const InputDecoration(
              labelText: 'Vehicle Type',
              hintText: 'Enter vehicle type',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _roadIdController,
            decoration: const InputDecoration(
              labelText: 'Road ID',
              hintText: 'Enter road ID',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _cameraIdController,
            decoration: const InputDecoration(
              labelText: 'Camera ID',
              hintText: 'Enter camera ID',
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () {
              addVehicleDetection();
            },
            child: const Text('Add Vehicle Detection'),
          ),
        ],
      ),
    );
  }
}