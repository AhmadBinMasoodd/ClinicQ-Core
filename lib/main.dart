import 'package:cliniq_core/controllers/equipement_controller.dart';
import 'package:cliniq_core/views/auth/auth_controller.dart';
import 'package:cliniq_core/views/auth/login_screen.dart';
import 'package:cliniq_core/views/dashboards/admin_homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'controllers/room_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Inject AuthController globally
  Get.put(AuthController());
  Get.put(RoomController());
  Get.put(EquipementController());
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
          seedColor: const Color(0xFF00BFA6), // Primary green
          primary: const Color(0xFF00BFA6),   // Primary green
          onPrimary: Colors.white,             // Text/icons on primary
          secondary: const Color(0xFF0078D7), // Secondary blue
          onSecondary: Colors.white,           // Text/icons on secondary
          background: const Color(0xFFF5F6FA),
          onBackground: Colors.black87,
          surface: Colors.white,
          onSurface: Colors.black87,
          error: Colors.redAccent,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF00BFA6), // Primary green
          foregroundColor: Colors.white,
          elevation: 2,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00BFA6), // Primary green
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF00BFA6), // Primary green
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF00BFA6),
            side: const BorderSide(color: Color(0xFF00BFA6)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          labelStyle: TextStyle(color: Colors.grey[700]),
        ),
        useMaterial3: true,
      ),


      // Set LoginScreen as the starting screen
      home: const AdminHomescreen(),
    );
  }
}
