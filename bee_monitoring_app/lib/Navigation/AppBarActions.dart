part of 'NagivationController.dart';

extension AppBarActions on _NagivationControllerState {
  static const String menuTitle = "Menu";
  static FileManager fm = FileManager();
  List<Widget> createAppBarActions(status) {
    return [
      Padding(
        padding:
            const EdgeInsets.only(left: 15, bottom: 15, right: 20, top: 20),
        child: DropdownButton(
            dropdownColor: Colors.amber,
            value: menuTitle,
            underline: const Text(''),
            icon: const Icon(Icons.menu),
            iconEnabledColor: Colors.black,
            items: [menuTitle, "Nova Coleta", "Exportar dados"]
                .map((String items) {
              return DropdownMenuItem(
                value: items,
                child: createAppBarActionsWidget(items),
              );
            }).toList(),
            onChanged: (String? newValue) async {
              if (newValue == 'Nova Coleta') {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    if (status == BleStatus.ready) {
                      return const DeviceListScreen();
                    } else {
                      return BleStatusScreen(
                          status: status ?? BleStatus.unknown);
                    }
                  }),
                );
              }
              if (newValue == 'Exportar dados') {
                await FileManager().exportJson(context);
              }
            }),
      ),
    ];
  }

  Widget createAppBarActionsWidget(String item) {
    switch (item) {
      case menuTitle:
        return const IgnorePointer(
          child: SizedBox(
            width: 140,
            child: Padding(
              padding: EdgeInsets.only(left: 0, bottom: 0, right: 5, top: 8),
              child: Text(
                menuTitle,
                style: TextStyle(
                    shadows: [
                      Shadow(color: Colors.black, offset: Offset(0, -5))
                    ],
                    decoration: TextDecoration.underline,
                    color: Color.fromARGB(0, 255, 255, 255),
                    fontWeight: FontWeight.w700,
                    decorationColor: Colors.black,
                    decorationThickness: 4,
                    fontSize: 18),
                textAlign: TextAlign.end,
              ),
            ),
          ),
        );

      default:
        return SizedBox(
          width: 140,
          child: Text(
            item,
            textAlign: TextAlign.end,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
          ),
        );
    }
  }
}
