import 'package:flutter/material.dart';

class DroneConfig extends StatefulWidget {
  const DroneConfig({super.key});

  @override
  State<DroneConfig> createState() => _DroneConfigState();
}

class _DroneConfigState extends State<DroneConfig> {
  final List<DroneData> drones = [
    DroneData(name: 'Atlas', type: 'Quad', status: 'Online'),
    DroneData(name: 'Voyager', type: 'VTOL', status: 'Standby'),
    DroneData(name: 'Specter', type: 'Quad', status: 'Offline'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: ListView.builder(
          itemCount: drones.length,
          itemBuilder: (context, index) {
            return DroneExpansionTile(drone: drones[index]);
          },
        ),
      ),
    );
  }
}

class DroneData {
  final String name;
  final String type;
  final String status;

  DroneData({required this.name, required this.type, required this.status});
}

class DroneExpansionTile extends StatefulWidget {
  final DroneData drone;

  const DroneExpansionTile({super.key, required this.drone});

  @override
  State<DroneExpansionTile> createState() => _DroneExpansionTileState();
}

class _DroneExpansionTileState extends State<DroneExpansionTile> {
  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (widget.drone.status) {
      case 'Online':
        statusColor = Colors.green;
        break;
      case 'Standby':
        statusColor = Colors.orange;
        break;
      case 'Offline':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.drone.name,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  widget.drone.type,
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  widget.drone.status,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Tooltip(
                  message: 'Signal Strength',
                  child: IconButton(
                    icon: const Icon(Icons.signal_cellular_alt,
                        color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                Tooltip(
                  message: 'Battery Level',
                  child: IconButton(
                    icon: const Icon(Icons.battery_full, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                Tooltip(
                  message: 'Configuration',
                  child: IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
