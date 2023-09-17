import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetAllData extends StatefulWidget {
  const GetAllData({Key? key}) : super(key: key);

  @override
  State<GetAllData> createState() => _GetAllDataState();
}

class _GetAllDataState extends State<GetAllData> {
  List<Map<String, dynamic>> cameras = [];
  List<Map<String, dynamic>> roads = [];
  List<Map<String, dynamic>> vehicleTypes = [];
  List<Map<String, dynamic>> vehicleDetections = [];

  Future<void> getAllData() async {
    var url = "https://gp-prototype-back-end-api.azurewebsites.net/";
    var response = await http.get(Uri.parse(url));
    var responseBody = jsonDecode(response.body);
    cameras = List<Map<String, dynamic>>.from(responseBody['cameras']);
    roads = List<Map<String, dynamic>>.from(responseBody['roads']);
    vehicleTypes =
        List<Map<String, dynamic>>.from(responseBody['vehicleTypes']);
    vehicleDetections =
        List<Map<String, dynamic>>.from(responseBody['vehicleDetections']);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Data'),
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
          ListTile(
            title: const Text('Roads'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: roads.map((road) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('RoadID: ${road["RoadID"]}'),
                    Text('RoadName: ${road["RoadName"]}'),
                    Text('Direction: ${road["Direction"]}'),
                    const Divider(),
                  ],
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: const Text('Vehicle Types'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: vehicleTypes.map((vehicleType) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TypeID: ${vehicleType["TypeID"]}'),
                    Text('TypeName: ${vehicleType["TypeName"]}'),
                    const Divider(),
                  ],
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: const Text('Vehicle Detections'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: vehicleDetections.map((detection) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('DetectionDate: ${detection["DetectionDate"]}'),
                    Text('VehicleTypeID: ${detection["VehicleTypeID"]}'),
                    Text('CameraID: ${detection["CameraID"]}'),
                    Text('RoadID: ${detection["RoadID"]}'),
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
