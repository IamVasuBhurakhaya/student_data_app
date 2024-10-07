import 'package:flutter/material.dart';
import 'package:student_data_app/utils/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, AppRoutes.home_page),
    );
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text("Splash Screen"),
          ],
        ),
      ),
    );
  }
}
