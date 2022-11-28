part of 'NagivationController.dart';

extension AppBarActions on _NagivationControllerState {
  static const String menuTitle = "Menu";
List<Widget> createAppBarActions() {
    return [
      Padding(
          padding: EdgeInsets.only(left: 15, bottom: 15, right: 20, top: 20),
          child: DropdownButton(
              dropdownColor: Colors.amber,
              value: menuTitle,
              icon: const Icon(Icons.menu),
              iconEnabledColor: Colors.white,
              items: [
                menuTitle,
                "Nova Coleta",
                "Minhas coletas",
                "Exportar dados"
              ].map((String items) {
                return DropdownMenuItem(
                    value: items, child: createAppBarActionsWidget(items));
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  // TODO: implementar Funções
                });
              })),
    ];
  }

  Widget createAppBarActionsWidget(String item) {
    switch (item) {
      case menuTitle:
      return IgnorePointer(
            child: Container(
            width: 140,
            child: Padding(
              padding: EdgeInsets.only(left: 0, bottom: 0, right: 5, top: 8),
              child: Text(
                menuTitle,
                style: TextStyle(
                    shadows: [
                      Shadow(
                          color: Color.fromARGB(255, 255, 255, 255),
                          offset: Offset(0, -5))
                    ],
                    color: Color.fromARGB(0, 255, 255, 255),
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w700,
                    decorationColor: Color.fromARGB(255, 255, 255, 255),
                    decorationThickness: 4,
                    fontSize: 18),
                textAlign: TextAlign.end,
              ),
            ),
          ));

      default:
      return Container(
            width: 140,
            child: Text(item,
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w500,
                    fontSize: 18)));
    }
  }

}