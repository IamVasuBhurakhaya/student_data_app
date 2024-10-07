import 'package:flutter/material.dart';
import 'package:student_data_app/views/detail_page/detail_page.dart';
import 'package:student_data_app/views/home_page/home_page.dart';
import 'package:student_data_app/views/splash_screen.dart';

class AppRoutes {
  static const String splash_screen = '/';
  static const String home_page = 'home_page';
  static const String detail_page = 'detail_page';

  static Map<String, WidgetBuilder> routes = {
    splash_screen: (context) => const SplashScreen(),
    home_page: (context) => const HomePage(),
    detail_page: (context) => const DetailPage(),
  };
}
