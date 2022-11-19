enum Type {
  temperatureInside("Temperatura Interna"),
  temperatureOutside("Temperatura Externa"),
  humidityInside("Umidade Interna"),
  humidityOutside("Umidade Externa"),
  sound("Som");

  const Type(this.value);
  final String value;
}