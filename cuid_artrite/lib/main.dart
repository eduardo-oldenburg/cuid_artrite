import 'package:flutter/material.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/auth/presentation/pages/login_page.dart'; // Import Login

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
      // 1. Change home to LoginPage
      home: const LoginPage(), 
      
      // 2. Add this so the "Entrar" button works
      routes: {
        '/home': (context) => const HomePage(),
      },
    );
  }
}