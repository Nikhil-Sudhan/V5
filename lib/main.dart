import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:version5/slides/config.dart';
import 'package:version5/slides/details.dart';
import 'package:version5/slides/mission.dart';
import 'package:version5/slides/task.dart';
import 'package:version5/slides/timeline.dart';


void main() => runApp(const MapApp());

class MapApp extends StatelessWidget {
  const MapApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          primaryColor: const Color(0xFF2A2A2A),
        ),
        home: const MapScreen(),
      );
}

class SidebarItem {
  final Widget icon;
  final String title;
  final Widget content;

  const SidebarItem({
    required this.icon,
    required this.title,
    required this.content,
  });
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String? leftSelectedTitle;
  String? rightSelectedTitle;
  Widget? leftSideContent;
  Widget? rightSideContent;

  final leftSidebarItems = [
    SidebarItem(
      icon: Image.asset('assets/icons/mission.png', width: 24, height: 24),
      title: 'Mission',
      content: const Mission(),
    ),
    SidebarItem(
      icon: Image.asset('assets/track_ic.png', width: 24, height: 24),
      title: 'Track',
      content: MissionTracker(
      ),
    ),
  ];

  void _handleSidebarItemTap(bool isLeft, SidebarItem item) {
    setState(() {
      if (isLeft) {
        if (leftSelectedTitle == item.title) {
          // If the same item is tapped again, hide it
          leftSelectedTitle = null;
          leftSideContent = null;
        } else {
          leftSelectedTitle = item.title;
          leftSideContent = item.content;
        }
      } else {
        if (rightSelectedTitle == item.title) {
          // If the same item is tapped again, hide it
          rightSelectedTitle = null;
          rightSideContent = null;
        } else {
          rightSelectedTitle = item.title;
          rightSideContent = item.content;
        }
      }
    });
  }

  final rightSidebarItems = [
    SidebarItem(
      icon: Image.asset('assets/icons/simulation.png', width: 24, height: 24),
      title: 'Details',
      content: const TaskDetails(
        status: 'status_value',
        action: 'action_value',
        asset: 'asset_value',
        objective: 'objective_value',
        objectiveId: 'objectiveId_value',
      ),
    ),
    SidebarItem(
      icon: Image.asset('assets/icons/config.png', width: 24, height: 24),
      title: 'Config',
      content: const DroneConfig(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              _buildTopBar(),
              Expanded(
                child: Row(
                  children: [
                    _buildSidebar(true),
                    if (leftSideContent != null)
                      _buildExpandedPanel(leftSelectedTitle!, leftSideContent!),
                    Expanded(
                      child: Container(
                        color: Colors.black,
                        child: const Center(
                          child: Text('Cesium Map Goes Here',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    if (rightSideContent != null)
                      _buildExpandedPanel(
                          rightSelectedTitle!, rightSideContent!),
                    _buildSidebar(false),
                  ],
                ),
              ),
            ],
          ),
           DroneTimeline(),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        border: Border.all(color: const Color(0xFF00FFFF), width: 1),
      ),
      child: Row(
        children: [
          Image.asset('assets/icons/playstore.png', height: 40),
          const Spacer(),
          _buildDateTime(),
          const SizedBox(width: 16),
          _buildOnlineStatus(),
        ],
      ),
    );
  }

  Widget _buildDateTime() {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, _) {
        return Text(
          DateFormat('MMM d yyyy, HH:mm:ss').format(DateTime.now()),
          style: const TextStyle(color: Colors.white),
        );
      },
    );
  }

  Widget _buildOnlineStatus() {
    return const Row(
      children: [
        CircleAvatar(
          radius: 4,
          backgroundColor: Colors.green,
        ),
        SizedBox(width: 8),
        Text('Online', style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildSidebar(bool isLeft) {
    final items = isLeft ? leftSidebarItems : rightSidebarItems;

    return Container(
      width: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        border: Border.all(color: const Color(0xFF00FFFF), width: 1),
      ),
      child: Column(
        children: items
            .map((item) => SizedBox(
                  height: 60, // Adjust this value for item height
                  width: 60, // Adjust this value for item width
                  child: IconButton(
                    icon: item.icon,
                    onPressed: () => _handleSidebarItemTap(isLeft, item),
                  ),
                ))
            .toList(),
      ),
    );
  }


  Widget _buildExpandedPanel(String title, Widget content) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        border: Border.all(color: const Color(0xFF00FFFF), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(title,
            style: const TextStyle(color: Colors.white, fontSize: 18)),
          ),
          Expanded(child: content),
        ],
      ),
    );
  }
}




