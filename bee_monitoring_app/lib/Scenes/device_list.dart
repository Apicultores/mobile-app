import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';

import '../Commons/ble/ble_scanner.dart';
import 'widgets.dart';
import 'device_detail/device_detail_screen.dart';

class DeviceListScreen extends StatelessWidget {
  const DeviceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer2<BleScanner, BleScannerState?>(
        builder: (_, bleScanner, bleScannerState, __) => _DeviceList(
          scannerState: bleScannerState ??
              const BleScannerState(
                discoveredDevices: [],
                scanIsInProgress: false,
              ),
          startScan: bleScanner.startScan,
          stopScan: bleScanner.stopScan,
          mtuSize: bleScanner.mtuSize,
        ),
      );
}

class _DeviceList extends StatefulWidget {
  const _DeviceList(
      {required this.scannerState,
      required this.startScan,
      required this.stopScan,
      required this.mtuSize});

  final BleScannerState scannerState;
  final void Function(List<Uuid>) startScan;
  final VoidCallback stopScan;
  final void Function(DiscoveredDevice) mtuSize;

  @override
  _DeviceListState createState() => _DeviceListState();
}

class _DeviceListState extends State<_DeviceList> {
  late TextEditingController _uuidController;

  @override
  void initState() {
    super.initState();
    _uuidController = TextEditingController()
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    widget.stopScan();
    _uuidController.dispose();
    super.dispose();
  }

  bool _isValidUuidInput() {
    final uuidText = _uuidController.text;
    if (uuidText.isEmpty) {
      return true;
    } else {
      try {
        Uuid.parse(uuidText);
        return true;
      } on Exception {
        return false;
      }
    }
  }

  void _startScanning() {
    final text = _uuidController.text;
    widget.startScan(text.isEmpty ? [] : [Uuid.parse(_uuidController.text)]);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Nova coleta'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text('Procurar por UUID (2, 4, 16 bytes):'),
                  TextField(
                    controller: _uuidController,
                    enabled: !widget.scannerState.scanIsInProgress,
                    decoration: InputDecoration(
                        errorText:
                            _uuidController.text.isEmpty || _isValidUuidInput()
                                ? null
                                : 'Formato de UUID inválido'),
                    autocorrect: false,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: !widget.scannerState.scanIsInProgress &&
                                _isValidUuidInput()
                            ? _startScanning
                            : null,
                        child: const Text('Procurar'),
                      ),
                      ElevatedButton(
                        onPressed: widget.scannerState.scanIsInProgress
                            ? widget.stopScan
                            : null,
                        child: const Text('Parar'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          !widget.scannerState.scanIsInProgress
                              ? 'Procure por um UUID específico ou aperte "Procurar" para listar os dispositivos próximos'
                              : 'Clique em um dispositivo para se conectar a ele',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (widget.scannerState.scanIsInProgress ||
                          widget.scannerState.discoveredDevices.isNotEmpty)
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.only(start: 18.0),
                          child: Text(
                              'Total: ${widget.scannerState.discoveredDevices.length}'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: ListView(
                children: widget.scannerState.discoveredDevices
                    .map(
                      (device) => ListTile(
                        title: Text(device.name),
                        subtitle: Text("${device.id}\nRSSI: ${device.rssi}"),
                        leading: const BluetoothIcon(),
                        onTap: () async {
                          widget.stopScan();
                          widget.mtuSize(device);
                          await Navigator.push<void>(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      DeviceDetailScreen(device: device)));
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      );
}
