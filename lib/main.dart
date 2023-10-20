import 'package:bondhu_mithai_app/Screen/Dashboard/AllCustomer.dart';
import 'package:bondhu_mithai_app/Screen/DeliveryMan/AllCustomer.dart';
import 'package:bondhu_mithai_app/Screen/DeveloperAccessories/developerThings.dart';
import 'package:bondhu_mithai_app/Screen/FrontScreen/FrontSlide.dart';
import 'package:bondhu_mithai_app/Screen/HomeScreen/Delivery/AllNewOrder.dart';
import 'package:bondhu_mithai_app/Screen/HomeScreen/Delivery/AllPackagingOrder.dart';
import 'package:bondhu_mithai_app/Screen/HomeScreen/FoodUploadScreen/FoodUploadScreen.dart';
import 'package:bondhu_mithai_app/Screen/HomeScreen/TableOrder/ChooseProduct.dart';
import 'package:bondhu_mithai_app/Screen/HomeScreen/TableOrder/TableOrder.dart';
import 'package:bondhu_mithai_app/Screen/HomeScreen/TableOrder/TableStructure.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {

  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');

  // WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool("showHome") ?? false;

  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  final bool showHome;

  const MyApp({super.key, required this.showHome});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorName().appColor),
        useMaterial3: true,
      ),
      home: showHome ? TableOrder(): FrontSlider(),
    );
  }
}
// ChooseProduct()
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
