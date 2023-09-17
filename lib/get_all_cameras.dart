import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetAllCameras extends StatefulWidget {
  const GetAllCameras({super.key});

  @override
  State<GetAllCameras> createState() => _GetAllCamerasState();
}

class _GetAllCamerasState extends State<GetAllCameras> {
  List<Map<String, dynamic>> cameras = [];
  Future getAllCameras() async {
    var url = "https://gp-prototype-back-end-api.azurewebsites.net/cameras";
    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);
    setState(() {
      cameras = List<Map<String, dynamic>>.from(responsebody);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getAllCameras();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Cameras'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Cameras'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cameras.map((camera) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CameraID: ${camera["CameraID"]}'),
                    Text('Model: ${camera["Model"]}'),
                    Text('Location: ${camera["Location"]}'),
                    const Divider(),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
