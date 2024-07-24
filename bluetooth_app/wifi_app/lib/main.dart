import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Wi-Fi App',
      home: WifiInfoScreen(),
    );
  }
}

class WifiInfoScreen extends StatefulWidget {
  const WifiInfoScreen({super.key});

  @override
  _WifiInfoScreenState createState() => _WifiInfoScreenState();
}

class _WifiInfoScreenState extends State<WifiInfoScreen> {
  String wifiName = 'Unknown';
  String wifiBSSID = 'Unknown';
  String wifiIP = 'Unknown';

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      _getWifiInfo();
    } else {
      _showPermissionDeniedDialog();
    }
  }

  Future<void> _getWifiInfo() async {
    String wifiNameResult = await WifiInfo().getWifiName() ?? 'Unknown SSID';
    String wifiBSSIDResult = await WifiInfo().getWifiBSSID() ?? 'Unknown BSSID';
    String wifiIPResult = await WifiInfo().getWifiIP() ?? 'Unknown IP Address';

    setState(() {
      wifiName = wifiNameResult;
      wifiBSSID = wifiBSSIDResult;
      wifiIP = wifiIPResult;
    });
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text('Location permission is required to get Wi-Fi information.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wi-Fi Info'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('SSID: $wifiName'),
            Text('BSSID: $wifiBSSID'),
            Text('IP Address: $wifiIP'),
            ElevatedButton(
              onPressed: _getWifiInfo,
              child: const Text('Refresh Wi-Fi Info'),
            ),
          ],
        ),
      ),
    );
  }
}
