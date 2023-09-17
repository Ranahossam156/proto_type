import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetAllRoads extends StatefulWidget {
  const GetAllRoads({super.key});

  @override
  State<GetAllRoads> createState() => _GetAllRoadsState();
}

class _GetAllRoadsState extends State<GetAllRoads> {
  List<Map<String, dynamic>> roads = [];
  Future getAllRoads() async {
    var url = "https://gp-prototype-back-end-api.azurewebsites.net/roads";
    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);
    setState(() {
      roads = List<Map<String, dynamic>>.from(responsebody);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getAllRoads();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Roads'),
      ),
      body: ListView(
        children: [
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
        ],
      ),
    );
  }
}
