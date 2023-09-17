import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetAllVehicleTypes extends StatefulWidget {
  const GetAllVehicleTypes({super.key});

  @override
  State<GetAllVehicleTypes> createState() => _GetAllVehicleTypesState();
}

class _GetAllVehicleTypesState extends State<GetAllVehicleTypes> {
  List<Map<String, dynamic>> vehicleTypes = [];
  Future getAllvehicles() async {
    var url =
        "https://gp-prototype-back-end-api.azurewebsites.net/vehicleTypes";
    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);
    setState(() {
      vehicleTypes = List<Map<String, dynamic>>.from(responsebody);
    });
  }

  void initState() {
    // TODO: implement initState
    getAllvehicles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Vehicle Type'),
      ),
      body: ListView(
        children: [
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
        ],
      ),
    );
  }
}
