part of 'package:bee_monitoring_app/Scenes/Chart/ChartViewController.dart';

extension ChartCheckboxWidgets on _ChartViewControllerState {
  Widget createTemperatureCheckbox() {
    return Row(
      children: <Widget>[
        Expanded(
          child: CheckboxListTile(
            title: const Text("Temperatura Interna"),
            value: _temperatureInsideIsVisible,
            onChanged: (newValue) {
              setState(() {
                _temperatureInsideIsVisible = newValue ?? true;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ),
        Expanded(
          child: CheckboxListTile(
            title: const Text("Temperatura Externa"),
            value: _temperatureOutsideIsVisible,
            onChanged: (newValue) {
              setState(() {
                _temperatureOutsideIsVisible = newValue ?? true;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
        )
      ],
    );
  }

  Widget createSoundCheckbox() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Center(
            child: CheckboxListTile(
              title: const Text("Som"),
              value: _soundIsVisible,
              onChanged: (newValue) {
                setState(() {
                  _soundIsVisible = newValue ?? true;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
        )
      ],
    );
  }

  Widget createHumidityCheckbox() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: CheckboxListTile(
            title: const Text("Humidade Interna"),
            value: _humidityInsideIsVisible,
            onChanged: (newValue) {
              setState(() {
                _humidityInsideIsVisible = newValue ?? true;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ),
        Expanded(
          flex: 5,
          child: CheckboxListTile(
            title: const Text("Humidade Externa"),
            value: _humidityOutsideIsVisible,
            onChanged: (newValue) {
              setState(() {
                _humidityOutsideIsVisible = newValue ?? true;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
        )
      ],
    );
  }
}
