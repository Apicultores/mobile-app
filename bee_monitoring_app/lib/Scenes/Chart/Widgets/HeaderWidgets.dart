part of 'package:bee_monitoring_app/Scenes/Chart/ChartViewController.dart';

extension HeaderWidgets on _ChartViewControllerState {
  Widget createHeader() {
    return Container(
      color: Colors.white,
      child: (Row(
        children: <Widget>[
          Padding(
              padding:
                  EdgeInsets.only(left: 15, bottom: 15, right: 20, top: 20),
              child: Text(
                "Coleta (ID123123 : 22/11/2020)",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal),
              )),
          Expanded(child: Container()),
          ElevatedButton(
            onPressed: () {
              showPopup();
            },
            style: ElevatedButton.styleFrom(primary: Colors.white),
            child: Icon(
              Icons.more_vert_sharp,
              size: 24.0,
            ),
          ),
          SizedBox(width: 10),
        ],
      )),
    );
  }

  Widget createGraphHeader() {
    return Padding(
        padding: EdgeInsets.only(left: 20, bottom: 5, right: 20, top: 25),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: ElevatedButton(
                child: Text('< Anterior'),
                onPressed: () {
                  updatePresentedChartData(UpdateChartMode.back);
                },
              ),
            ),
            Padding(
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
                child: Text('Próximo >'),
                onPressed: () {
                  updatePresentedChartData(UpdateChartMode.next);
                },
              ),
            )
          ],
        ));
  }
}
