import 'package:flutter/material.dart';
import 'package:bdappsclass2/productlistscreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'bdapps 2nd class ecommerce app',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: ProductListScreen(),
    );
  }
}
