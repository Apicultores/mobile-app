class ChartItem {
  final String month;

  final double temperatureInside;
  final double temperatureOutside;

  final double humidityInside;
  final double humidityOutside;

  final double sound;

  ChartItem(this.month, this.temperatureInside, this.temperatureOutside,
      this.humidityInside, this.humidityOutside, this.sound);
}

  enum UpdateMode {
    back;
    next;
  }