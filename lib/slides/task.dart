import 'package:flutter/material.dart';

class MissionTracker extends StatelessWidget {
  
  const MissionTracker({
    super.key,
    
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF1A1A1A),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {}, // Use the onClose callback here
                    ),
                    // Rest of the top bar code remains the same...
                    const Text(
                      'DD GENERAL',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'ONLINE',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    const Spacer(),
                    // IconButton(
                    //   icon: const Icon(Icons.settings, color: Colors.white),
                    //   onPressed: () {},
                    // ),
                    IconButton(
                      icon: const Icon(Icons.visibility, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.star_border, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              // Rest of your widgets remain the same...
              // Mission Info section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Friendly',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Data Type: anduril',
                      style: TextStyle(color: Colors.white),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Simulated',
                        style: TextStyle(color: Colors.green, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),

              // Player Controls
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.skip_previous, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.pause, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next, color: Colors.white),
                      onPressed: () {},
                    ),
                    const Text(
                      '03DEC24 00:02Z - LIVE',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),

              // Expandable Sections
              ExpansionTile(
                title:
                    const Text('TASKS', style: TextStyle(color: Colors.white)),
                children: [
                  ListTile(
                    leading: const Icon(Icons.mic, color: Colors.white),
                    title: Row(
                      children: [
                        const Text('DD GENERAL',
                            style: TextStyle(color: Colors.white)),
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          child:
                              const Icon(Icons.phishing, color: Colors.orange),
                        ),
                      ],
                    ),
                    subtitle: const Text('1h 21m',
                        style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),

              ExpansionTile(
                title: const Text('ASSET DATA',
                    style: TextStyle(color: Colors.white)),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildDataRow('Activity', 'Unknown'),
                        _buildDataRow('Speed', '45 mph'),
                        _buildDataRow('Last Updated', '1s'),
                        _buildDataRow('Created', '12/2/2024, 19:00:04'),
                        _buildDataRow('Altitude', '35 ft MSL'),
                        _buildDataRow('Heading', '218°'),
                        _buildDataRow('Location', '-25.03016°, 53.90943°'),
                        _buildDataRow('Time Since Creation', '42m 54s'),
                      ],
                    ),
                  ),
                ],
              ),

              ExpansionTile(
                title: const Text('PAYLOADS',
                    style: TextStyle(color: Colors.white)),
                children: const [
                  ListTile(
                    title: Text('Task', style: TextStyle(color: Colors.orange)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
