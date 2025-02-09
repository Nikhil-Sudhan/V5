import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DroneDataScreen(),
    );
  }
}

class DroneDataScreen extends StatefulWidget {
  @override
  _DroneDataScreenState createState() => _DroneDataScreenState();
}

class _DroneDataScreenState extends State<DroneDataScreen> {
  List<dynamic> drones = [];

  Future<void> fetchDrones() async {
    final response = await http.get(Uri.parse("http://localhost:8000/drones"));
    
    if (response.statusCode == 200) {
      setState(() {
        drones = json.decode(response.body);
      });
    } else {
      throw Exception("Failed to load drone data");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDrones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Drone Data")),
      body: drones.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: drones.length,
              itemBuilder: (context, index) {
                var drone = drones[index];
                return ListTile(
                  title: Text("Drone ID: ${drone['id']} - ${drone['status']}"),
                  subtitle: Text(
                      "Type: ${drone['type']} | Battery: ${drone['battery_percentage'] ?? 'N/A'}%"),
                );
              },
            ),
    );
  }
}
