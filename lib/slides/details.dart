import 'package:flutter/material.dart';

class TaskDetails extends StatelessWidget {
  final String status;
  final String action;
  final String asset;
  final String objective;
  final String objectiveId;

  const TaskDetails({
    super.key,
    required this.status,
    required this.action,
    required this.asset,
    required this.objective,
    required this.objectiveId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text('Task Details'),
            actions: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(19.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
                Text(
                  action,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.water_drop, color: Colors.cyan),
                    Text(
                      asset,
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(Icons.arrow_forward, color: Colors.grey),
                    Icon(Icons.local_fire_department, color: Colors.orange),
                    Text(
                      'FISHING V...',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton.icon(
                      icon: Icon(Icons.edit),
                      label: Text('Edit'),
                      onPressed: () {},
                    ),
                    OutlinedButton.icon(
                      icon: Icon(Icons.check),
                      label: Text('Complete'),
                      onPressed: () {},
                    ),
                    OutlinedButton.icon(
                      icon: Icon(Icons.close),
                      label: Text('Cancel'),
                      onPressed: () {},
                      style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all(Colors.red),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Task parameters',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                ListTile(
                  title: Text('Asset', style: TextStyle(color: Colors.grey)),
                  subtitle: Row(
                    children: [
                      Icon(Icons.water_drop, color: Colors.cyan, size: 16),
                      Text(
                        asset,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text('Objective', style: TextStyle(color: Colors.grey)),
                  subtitle: Text(
                    '$objective\n($objectiveId)',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text(
                    'In Case of Task Conflict:',
                    style: TextStyle(color: Colors.grey),
                  ),
                  subtitle: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Replace current task',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Icon(Icons.arrow_drop_down, color: Colors.grey),
                      ],
                    ),
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