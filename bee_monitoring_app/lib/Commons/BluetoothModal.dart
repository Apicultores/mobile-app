import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DecisionModal extends StatefulWidget {
  final List<BluetoothDevice> devicesList;
  const DecisionModal({Key? key, required this.devicesList}) : super(key: key);

  @override
  State<DecisionModal> createState() => _DecisionModalState();
}

class _DecisionModalState extends State<DecisionModal> {
  List<Widget> _renderCards() {
    if (widget.devicesList.isEmpty) {
      return [
        const Center(
          child: CircularProgressIndicator(
            strokeWidth: 6,
          ),
        ),
      ];
    }

    List<Widget> containers = [];
    for (BluetoothDevice device
        in widget.devicesList.where((element) => element.name.isNotEmpty)) {
      containers.add(
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(device.name),
                    Text(device.id.toString())
                  ],
                ),
              ),
              ElevatedButton(
                child: const Text(
                  'Connect',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {},
              ),
            ],
          ),
        ),
      );
    }
    return containers;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(20),
      children: [
        SizedBox(
          height: 200.0, // Change as per your requirement
          width: 300.0,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10.0),
              children: _renderCards(),
            ),
          ),
        ),
      ],
    );
  }
}
