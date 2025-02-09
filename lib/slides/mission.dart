import 'package:flutter/material.dart';

class Mission extends StatefulWidget {
  const Mission({super.key});

  @override
  State<Mission> createState() => _MissionState();
}

class _MissionState extends State<Mission> {
  String? selectedMissionType;
  String? selectedVehicle;
  TextEditingController promptController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mission Type Selection
          const Text('Select Mission Type:',
              style: TextStyle(color: Colors.white)),
          DropdownButton<String>(
            dropdownColor: Colors.grey[800],
            value: selectedMissionType,
            items: <String>['Area Search', 'Emergency', 'Surveillance']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(color: Colors.white)),
              );
            }).toList(),
            hint: const Text('Choose a mission type',
                style: TextStyle(color: Colors.grey)),
            onChanged: (String? newValue) {
              setState(() {
                selectedMissionType = newValue;
              });
            },
          ),
          const SizedBox(height: 20),

          // Vehicle Selection
          const Text('Select Vehicle:', style: TextStyle(color: Colors.white)),
          DropdownButton<String>(
            dropdownColor: Colors.grey[800],
            value: selectedVehicle,
            items: <String>['Atlas', 'Voyager', 'Specter']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(color: Colors.white)),
              );
            }).toList(),
            hint: const Text('Choose a vehicle',
                style: TextStyle(color: Colors.grey)),
            onChanged: (String? newValue) {
              setState(() {
                selectedVehicle = newValue;
              });
            },
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
          ),
          const SizedBox(height: 20),

          // Assign Task Button
          ElevatedButton(
            onPressed: () {
              print('Mission Type: $selectedMissionType');
              print('Vehicle: $selectedVehicle');
              print('Prompt: ${promptController.text}');
            },
            child: const Text('Assign Task'),
          ),
        ],
      ),
    );
  }
}
