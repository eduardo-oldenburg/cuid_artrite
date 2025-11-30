// em lib/main.dart
import 'package:flutter/material.dart';
import 'features/home/presentation/pages/home_page.dart'; // Importe o arquivo

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CuidArtrite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const HomePage(), // Chame a HomePage aqui mudanca
    );
  }
}