import 'package:flutter/material.dart';

class DroneTimeline extends StatefulWidget {
  const DroneTimeline({super.key});
  @override
  State<DroneTimeline> createState() => _TimelineState();
}

class _TimelineState extends State<DroneTimeline> {
  bool isTimelineExpanded = false;
  
  final List<DroneData> drones = [
    DroneData(
      name: 'AEROSONDE',
      steps: [
        StepData(type: 'Find', coordinates: '33.07540°, -114.33601°'),
        StepData(type: 'Hold'),
        StepData(type: 'Fix'),
        StepData(type: 'Finish'),
      ],
    ),
    DroneData(
      name: 'ALTIUS 600 ISR',
      steps: [
        StepData(type: 'Find', coordinates: '33.07542°, -114.31466°'),
        StepData(type: 'Hold'),
        StepData(type: 'Fix'),
        StepData(type: 'Finish'),
      ],
    ),
  ];

  Widget _buildTimelineContent() {
    return Container(
      color: const Color(0xFF1A1A1A),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Plan Line EDGE23 v2.0',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ...drones.map((drone) => DroneRow(drone: drone)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          border: Border.all(color: const Color(0xFF00FFFF), width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => setState(() => isTimelineExpanded = !isTimelineExpanded),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Timeline', style: TextStyle(color: Colors.white)),
              ),
            ),
            if (isTimelineExpanded)
              SizedBox(
                height: 160,
                child: _buildTimelineContent(),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildTimelineBar(),
      ],
    );
  }
}

class DroneRow extends StatelessWidget {
  final DroneData drone;

  const DroneRow({super.key, required this.drone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              drone.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: drone.steps
                  .asMap()
                  .map((index, step) => MapEntry(
                        index,
                        Expanded(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              if (index < drone.steps.length - 1)
                                Positioned(
                                  left: 50,
                                  right: 0,
                                  child: Container(
                                    height: 2,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              StepCard(step: step),
                            ],
                          ),
                        ),
                      ))
                  .values
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class StepCard extends StatelessWidget {
  final StepData step;

  const StepCard({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        border: Border.all(color: Colors.grey[800]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            step.type.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (step.coordinates != null) ...[
            const SizedBox(height: 4),
            Text(
              step.coordinates!,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 10,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class DroneData {
  final String name;
  final List<StepData> steps;

  DroneData({required this.name, required this.steps});
}

class StepData {
  final String type;
  final String? coordinates;

  StepData({required this.type, this.coordinates});
}


