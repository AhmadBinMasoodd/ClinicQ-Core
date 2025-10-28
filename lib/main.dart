import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ClinicQ-Core',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0078D7),
          primary: const Color(0xFF0078D7),
          secondary: const Color(0xFF00BFA6), // Teal green accent
          background: const Color(0xFFF5F6FA),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
        fontFamily: 'Poppins',
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF0078D7),
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF0078D7),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClinicQ-Core'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: const Center(
        child: Text('Welcome to ClinicQ-Core', style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
