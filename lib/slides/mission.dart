import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Mission extends StatefulWidget {
  const Mission({super.key});

  @override
  State<Mission> createState() => _MissionState();
}

class _MissionState extends State<Mission> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? selectedMissionType;
  String? selectedVehicle;
  TextEditingController promptController = TextEditingController();
  List<String> vehicleList = [];

  @override
  void initState() {
    super.initState();
    fetchVehicles();
  }

  

  Future<void> fetchVehicles() async {
    final response = await http.get(Uri.parse('http://localhost:8000/drones'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      Map<String, int> nameCount = {};

      setState(() {
        vehicleList = data.map((e) {
          String name = e['name'].toString();
          nameCount[name] = (nameCount[name] ?? 0) + 1;
          return nameCount[name]! > 1 ? '$name[${nameCount[name]}]' : name;
        }).toList();
      });
    } else {
      print('Failed to load vehicles');
    }
  }

  Future<void> _assignTask() async {
  if (_formKey.currentState!.validate()) {
    final url = Uri.parse('http://localhost:8000/assign_task');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'mission_type': selectedMissionType,
        'vehicle': selectedVehicle,
        'prompt': promptController.text,
      }),
    );

    if (response.statusCode == 200) {
      print("Task assigned successfully!");
    } else {
      print("Failed to assign task.");
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mission Type Selection
            const Text('Select Mission Type:', style: TextStyle(color: Colors.white)),
            DropdownButtonFormField<String>(
              dropdownColor: Colors.grey[800],
              value: selectedMissionType,
              items: <String>['Area Search', 'Emergency', 'Surveillance']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(color: Colors.white)),
                );
              }).toList(),
              hint: const Text('Choose a mission type', style: TextStyle(color: Colors.grey)),
              onChanged: (String? newValue) {
                setState(() {
                  selectedMissionType = newValue;
                });
              },
              validator: (value) => value == null ? 'Please select a mission type' : null,
            ),
            const SizedBox(height: 20),

            // Vehicle Selection
            const Text('Select Vehicle:', style: TextStyle(color: Colors.white)),
            DropdownButtonFormField<String>(
              dropdownColor: Colors.grey[800],
              value: selectedVehicle,
              items: vehicleList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(color: Colors.white)),
                );
              }).toList(),
              hint: const Text('Choose a vehicle', style: TextStyle(color: Colors.grey)),
              onChanged: (String? newValue) {
                setState(() {
                  selectedVehicle = newValue;
                });
              },
              validator: (value) => value == null ? 'Please select a vehicle' : null,
            ),
            const SizedBox(height: 20),

            // Prompt Input
            const Text('Enter Prompt:', style: TextStyle(color: Colors.white)),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: promptController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Enter your prompt here',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade700),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter a prompt' : null,
            ),
            const SizedBox(height: 20),

            // Assign Task Button
            ElevatedButton(
  onPressed: () {
    if (selectedMissionType == null ||
        selectedVehicle == null ||
        promptController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields must be filled!')),
      );
    } else {
      _assignTask();
    }
  },
  child: const Text('Assign Task'),
),

          ],
        ),
      ),
    );
  }
}
