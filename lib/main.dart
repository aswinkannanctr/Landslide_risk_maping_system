import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:land_slade_guardian/firebase_options.dart';
import 'package:land_slade_guardian/pages/login.dart';

Future<void> main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Landslide Guardian',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFBEAA8F), // Beige/tan color from the image
        ),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
