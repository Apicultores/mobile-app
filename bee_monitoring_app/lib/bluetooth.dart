import 'dart:async';

import 'package:bee_monitoring_app/Commons/BluetoothModal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Bluetooth extends StatefulWidget {
  const Bluetooth({super.key});

  @override
  State<Bluetooth> createState() => _BluetoothState();
}

class _BluetoothState extends State<Bluetooth> {
  final List<BluetoothDevice> _devicesList = [];

  void _addDeviceTolist(BluetoothDevice device) {
    if (!_devicesList.contains(device)) {
      setState(() {
        _devicesList.add(device);
      });
    }
  }

  Future _conectBluetooth() async {
    FlutterBlue flutterBlue = FlutterBlue.instance;

    flutterBlue.stopScan();

    flutterBlue.connectedDevices.asStream().listen((devices) {
      for (var device in devices) {
        _addDeviceTolist(device);
      }
    });
    await flutterBlue.startScan(timeout: const Duration(seconds: 4));
    flutterBlue.scanResults.listen(
      (scanResults) {
        for (var result in scanResults) {
          _addDeviceTolist(result.device);
        }
      },
      onDone: () => flutterBlue.stopScan(),
    );
  }

  void _handleModal() async {
    showDialog(
      context: context,
      builder: (_) => const DecisionModal(
        devicesList: [],
      ),
    );
    await _conectBluetooth();
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (_) => DecisionModal(
        devicesList: _devicesList,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24),
              ),
              onPressed: () async {
                _handleModal();
              },
              child: const Icon(
                Icons.bluetooth_searching_rounded,
                size: 100,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: Text(
                'Coletar dados da colméia por bluetooth',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
