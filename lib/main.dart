import 'package:battery_charger/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const platform = MethodChannel('battery_channel');

  String _chargerStatus = "Waiting for a change in charging status..";

  String _batteryStatus = "";
  Map<dynamic, dynamic>? _batteryInfo;

  @override
  void initState() {
    super.initState();

    // Listen for charger connect/disconnect from native
    platform.setMethodCallHandler((call) async {
      if (call.method == "onBatteryConnected") {
        setState(() {
          _chargerStatus = "Charger Connected ⚡";
        });
      } else if (call.method == "onBatteryDisconnected") {
        setState(() {
          _chargerStatus = "Charger Disconnected 🔌";
        });
      }
      _getBatteryInfo();
    });
  }

  Future<void> _getBatteryInfo() async {
    try {
      final info = await platform.invokeMethod<Map<dynamic, dynamic>>(
        'getBatteryInfo',
      );
      setState(() {
        _batteryInfo = info;
        _batteryStatus = "Battery Info Updated ✅";
      });
    } on PlatformException catch (e) {
      setState(() {
        _batteryStatus = "Failed: ${e.message}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(title: const Text("Battery Native Example")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _chargerStatus,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
              ),

              Text(
                _batteryStatus,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              if (_batteryInfo != null) ...[
                Text("Level: ${_batteryInfo?['level']}%"),
                Text("Status: ${Status.values[_batteryInfo?['status']].title}"),
                Text("Health: ${Health.values[_batteryInfo?['health']].title}"),
                Text(
                  "Plugged: ${Plugged.values[_batteryInfo?['plugged']].title}}",
                ),
                Text("Temp: ${_batteryInfo?['temperature']} °C"),
                Text("Voltage: ${_batteryInfo?['voltage']} mV"),
                Text("Tech: ${_batteryInfo?['technology']}"),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getBatteryInfo,
                child: const Text("Get Battery Info"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
