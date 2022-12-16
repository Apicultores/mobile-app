import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BleStatusScreen extends StatelessWidget {
  const BleStatusScreen({required this.status, Key? key}) : super(key: key);

  final BleStatus status;

  String determineText(BleStatus status) {
    switch (status) {
      case BleStatus.unsupported:
        return "Esse dispositivo não suporta Bluetooth";
      case BleStatus.unauthorized:
        return "Autorize o aplicativo a usar Bluetooth e localização";
      case BleStatus.poweredOff:
        return "Bluetooth está desligado em seu dispositivo, ligue-o";
      case BleStatus.locationServicesDisabled:
        return "Habilite a localização";
      case BleStatus.ready:
        return "Bluetooth ligado";
      default:
        return "Aguardando status do Bluetooth $status";
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Text(determineText(status)),
        ),
      );
}
