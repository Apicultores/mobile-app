part of 'package:bee_monitoring_app/Scenes/Chart/ChartViewController.dart';

extension HeaderWidgets on _ChartViewControllerState {
  Widget createHeader(Item? item) {
    if (item == null) return Container();
    return Container(
      color: Colors.white,
      child: (Row(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(
                  left: 15, bottom: 15, right: 20, top: 20),
              child: Text(
                "Coleta (${widget.dateFormat.format(item.timestamp)})",
                style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal),
              )),
          ElevatedButton(
            onPressed: () {
              showPopup();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: const Icon(
              Icons.more_vert_sharp,
              size: 24.0,
            ),
          ),
        ],
      )),
    );
  }

  Widget createGraphHeader() {
    return Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 5, right: 20, top: 25),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: ElevatedButton(
                child: const Text('< Anterior'),
                onPressed: () {
                  updatePresentedChartData(UpdateChartMode.back);
                },
              ),
            ),
            const Padding(
                padding:
                    EdgeInsets.only(left: 15, bottom: 20, right: 20, top: 20),
                child: Text(
                  "Medições",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                )),
            Expanded(
              flex: 3,
              child: ElevatedButton(
                child: const Text('Próximo >'),
                onPressed: () {
                  updatePresentedChartData(UpdateChartMode.next);
                },
              ),
            )
          ],
        ));
  }
}
