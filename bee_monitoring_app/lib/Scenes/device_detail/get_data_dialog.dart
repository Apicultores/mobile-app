import 'dart:async';

import 'package:bee_monitoring_app/Commons/services/file_manager.dart';
import 'package:bee_monitoring_app/Commons/repository/json_data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';

import '../../Commons/ble/ble_device_interactor.dart';

class GetDataDialog extends StatelessWidget {
  const GetDataDialog({
    required this.isWritableWithResponse,
    required this.isReadNotify,
    Key? key,
  }) : super(key: key);
  final QualifiedCharacteristic isWritableWithResponse;
  final QualifiedCharacteristic isReadNotify;

  @override
  Widget build(BuildContext context) => Consumer<BleDeviceInteractor>(
      builder: (context, interactor, _) => _GetDataDialog(
            isWritableWithResponse: isWritableWithResponse,
            isReadNotify: isReadNotify,
            writeWithResponse: interactor.writeCharacterisiticWithResponse,
            subscribeToCharacteristic: interactor.subScribeToCharacteristic,
          ));
}

class _GetDataDialog extends StatefulWidget {
  const _GetDataDialog({
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
  _GetDataDialogState createState() => _GetDataDialogState();
}

class _GetDataDialogState extends State<_GetDataDialog> {
  late TextEditingController textEditingController;
  late StreamSubscription<List<int>>? subscribeStream;
  final FileManager fm = FileManager();

  @override
  void initState() {
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
    List<int> output = [];
    try {
      subscribeStream = widget
          .subscribeToCharacteristic(widget.isReadNotify)
          .timeout(const Duration(seconds: 20), onTimeout: (sink) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Erro ao coletar dados, por favor tente novamente"),
          ),
        );
        Navigator.pop(context);
      }).listen((event) async {
        if (String.fromCharCodes(event) == '@') {
          await fm.writeJsonFile(output);
          await context.read<JsonRepository>().readData();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green.shade600,
              content: const Text("Dados coletados com sucesso"),
            ),
          );
          Navigator.pop(context);
        }
        output += event;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Erro ao coletar dados, por favor tente novamente"),
        ),
      );
      Navigator.pop(context);
    }
  }

  Future<void> writeCharacteristicWithResponse() async {
    await widget.writeWithResponse(widget.isWritableWithResponse, [103]);
  }

  @override
  Widget build(BuildContext context) => const Center(
        child: CircularProgressIndicator(),
      );
}
