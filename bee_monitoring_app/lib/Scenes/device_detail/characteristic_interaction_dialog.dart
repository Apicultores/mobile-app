import 'dart:async';

import 'package:bee_monitoring_app/Commons/services/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';

import '../../Commons/ble/ble_device_interactor.dart';

class CharacteristicInteractionDialog extends StatelessWidget {
  const CharacteristicInteractionDialog({
    required this.isWritableWithResponse,
    required this.isReadNotify,
    Key? key,
  }) : super(key: key);
  final QualifiedCharacteristic isWritableWithResponse;
  final QualifiedCharacteristic isReadNotify;

  @override
  Widget build(BuildContext context) => Consumer<BleDeviceInteractor>(
      builder: (context, interactor, _) => _CharacteristicInteractionDialog(
            isWritableWithResponse: isWritableWithResponse,
            isReadNotify: isReadNotify,
            writeWithResponse: interactor.writeCharacterisiticWithResponse,
            subscribeToCharacteristic: interactor.subScribeToCharacteristic,
          ));
}

class _CharacteristicInteractionDialog extends StatefulWidget {
  const _CharacteristicInteractionDialog({
    required this.isWritableWithResponse,
    required this.isReadNotify,
    required this.writeWithResponse,
    required this.subscribeToCharacteristic,
    Key? key,
  }) : super(key: key);

  final QualifiedCharacteristic isWritableWithResponse;
  final QualifiedCharacteristic isReadNotify;
  final Future<void> Function(
          QualifiedCharacteristic characteristic, List<int> value)
      writeWithResponse;

  final Stream<List<int>> Function(QualifiedCharacteristic characteristic)
      subscribeToCharacteristic;

  @override
  _CharacteristicInteractionDialogState createState() =>
      _CharacteristicInteractionDialogState();
}

class _CharacteristicInteractionDialogState
    extends State<_CharacteristicInteractionDialog> {
  late String subscribeOutput;
  late TextEditingController textEditingController;
  late StreamSubscription<List<int>>? subscribeStream;
  final FileManager fm = FileManager();

  @override
  void initState() {
    subscribeOutput = '';
    textEditingController = TextEditingController();
    super.initState();
    handleDataCollection();
  }

  Future handleDataCollection() async {
    await subscribeCharacteristic();
    await writeCharacteristicWithResponse();
  }

  @override
  void dispose() {
    subscribeStream?.cancel();
    super.dispose();
  }

  Future<void> subscribeCharacteristic() async {
    subscribeStream = widget
        .subscribeToCharacteristic(widget.isReadNotify)
        .listen((event) async {
      if (String.fromCharCodes(event) == '!@##@!') {
        print('subscribeOutput: $subscribeOutput');
        Navigator.pop(context);
      }
      await fm.writeJsonFile(event);
      setState(() {
        subscribeOutput += String.fromCharCodes(event);
      });
    });
  }

  Future<void> writeCharacteristicWithResponse() async {
    await widget.writeWithResponse(widget.isWritableWithResponse, [103]);
  }

  @override
  Widget build(BuildContext context) => const Center(
        child: CircularProgressIndicator(),
      );
}
