# Bee Monitoring App

Este é um projeto criado para o PFG (Projeto final de graduação) Unicamp 2022. O projeto é um aplicativo feito em flutter com o intuito de monitorar uma colméia. O aplicativo  se comunica com um microcontrolador via bluetooth low energy para pegar os dados coletados e renderiza-los em gráficos para análise do usuário final. O desenvolvimento do aplicativo foi focado na plataforma android.

## Começando

Para execução do aplicativo é necessário ter configurado um ambiente de desenvolvimento flutter, para isso pode-se seguir o tutorial no página principal do flutter no link abaixo:
```
https://docs.flutter.dev/get-started/install
```
O projeto contém toda implementação necessária para execução em dispositivos android. Basta apenas conceder a permissão de comunicação bluetooth para o app nas configurações do aparelho.


## Como utilizar

**Step 1: Clone**

Faça o download ou clone este repositório utilizando o link abaixo:

```
https://github.com/Apicultores/mobile-app.git
```

**Step 2: Install**

Vá para a pasta bee_monitoring_app e execute o seguinte comando para instalar todas as dependências:

```
flutter pub get 
```

**Step 3: run**

Para rodar o aplicativo, execute o comando abaixo, ou inicie a partir da IDE a ser utilizda:

```
flutter run
```

**Step 4: Build**

Para gerar um novo apk de release da aplicação rode o comando abaixo:
```
flutter build apk --release 
```
O build gerado se encontrará no diretório:
```
mobile-app/bee_monitoring_app/build/app/outputs/apk/release/app-release.apk
```

### Bibliotecas utilizadas


* [Provider](https://github.com/rrousselGit/provider) (State Management)
* [syncfusion_flutter_charts](https://pub.dev/packages/syncfusion_flutter_charts)
* [flutter_screenutil](https://pub.dev/packages/flutter_screenutil)
* [syncfusion_flutter_gauges](https://pub.dev/packages/syncfusion_flutter_gauges)
* [path_provider](https://pub.dev/packages/path_provider)
* [flutter_reactive_ble](https://pub.dev/packages/flutter_reactive_ble)
* [share_plus](https://pub.dev/packages/share_plus)

### Estrutura de pastas

Essa é a estrutura de pasta utilizada nesse projeto:

```
lib/
|- Commons/
	|- ble
	|- Enums
	|- Models
	|- repository
	|- services
	|- services.dart
|- Navigation/
|- Scenes/
|- main.dart
```