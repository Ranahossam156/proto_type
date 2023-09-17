import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetAllVehicleDetections extends StatefulWidget {
  const GetAllVehicleDetections({super.key});

  @override
  State<GetAllVehicleDetections> createState() =>
      _GetAllVehicleDetectionsState();
}

class _GetAllVehicleDetectionsState extends State<GetAllVehicleDetections> {
  List<Map<String, dynamic>> vehicleDetections = [];

  Future getAllvehiclesDetections() async {
    var url =
        "https://gp-prototype-back-end-api.azurewebsites.net/vehicleDetections";
    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);
    setState(() {
      vehicleDetections =
        List<Map<String, dynamic>>.from(responsebody);
    });
  }
  void initState() {
    // TODO: implement initState
     getAllvehiclesDetections();
    super.initState();
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
