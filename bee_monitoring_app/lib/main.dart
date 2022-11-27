import 'package:bee_monitoring_app/homeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apicultores',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: HomeScreen(),
    );
  }
}

//  import 'package:flutter/material.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
      
//       home: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return HomeScreen();
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   HomeScreenState createState() => HomeScreenState();
// }

// class HomeScreenState extends State<HomeScreen> {
//   String? dropdownValue;
//   List<Product> products = [
//     Product('sep1', 'sep'),
//     Product('milk', 'data'),
//     Product('oil', 'data'),
//     Product('sep2', 'sep'),
//     Product('suger', 'data'),
//     Product('salt', 'data'),
//     Product('sep3', 'sep'),
//     Product('potatoe', 'data'),
//     Product('tomatoe', 'data'),
//     Product('apple', 'data'),
//   ];

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('text')),
//       body: Column(
//         children: [
//           SizedBox(height: 20),
//           Text('test'),
//           SizedBox(height: 20),
//           Expanded(
//             child: DropdownButton<String>(
//               value: dropdownValue,
//               items: products.map((value) {
//                 return DropdownMenuItem(
//                   value: value.name,
//                   child: value.type == 'data'
//                       ? Text(value.name)
//                       : Divider(
//                           color: Colors.red,
//                           thickness: 3,
//                         ),
//                 );
//               }).toList(),
//               onChanged: (newValue) {
                
//                 setState(() {
                  
//                     // dropdownValue = newValue;
                  
//                 });
//                 print('$newValue $dropdownValue');
                
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Product {
//   String name;
//   String type;

//   Product(this.name, this.type);
// }