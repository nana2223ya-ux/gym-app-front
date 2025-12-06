import 'package:flutter/material.dart';
import 'package:gym_app/Screens/Register.dart';
import 'package:gym_app/Screens/home_view.dart';
import 'package:gym_app/Screens/login.dart';

void main() {
  runApp(const GymApp());
}

class GymApp extends StatelessWidget {
  const GymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/Register': (context) => RegisterScreen(),
        '/Home': (context) => HomeView(),
      },
      home: const LoginScreen(),
    );
  }
}
