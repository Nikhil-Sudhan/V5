class Drone {
  final int? id;
  final String name;
  final String type;
  final String status;
  final int? signal;
  final int? battery;
  final bool? connect;
  final bool? calibrate;

  const Drone({
    this.id,
    required this.name,
    required this.type,
    required this.status,
    this.signal,
    this.battery,
    this.connect,
    this.calibrate,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'status': status,
        'signal': signal,
        'battery': battery,
        'connect': connect,
        'calibrate': calibrate,
      };

  Drone.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = json['type'],
        status = json['status'],
        signal = json['signal'],
        battery = json['battery'],
        connect = json['connect'],
        calibrate = json['calibrate'];
}