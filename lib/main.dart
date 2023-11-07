import 'package:flutter/material.dart';
import 'package:waterways/OrderManagement/orderpageone.dart';
import 'package:waterways/OrderManagement/orderpagethree.dart';
import 'package:waterways/OrderManagement/orderpagetwo.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WaterWays Ilong',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xffF8F8F8),
        body: SafeArea(
          child: OrderPageOne(title: '',),
        ),
      ),
    );
  }
}