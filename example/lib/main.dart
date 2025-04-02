import 'package:flutter/material.dart';
import 'package:flutter_flag_selector/flutter_flag_selector.dart';

import 'package:flutter_flag_selector/src/models/country_modell.dart';
void main() {
  CountryService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flag Selector Demo')),
        body: const Center(
          child: FlagSelector(
          
           
          
          ),
        ),
      ),
    );
  }
}