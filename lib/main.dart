import 'package:flutter/material.dart';
import 'package:timer_app/utills/routes/routes.dart';
import 'package:timer_app/views/screens/clockpage/clockpage.dart';
import 'package:timer_app/views/screens/splashscreen/splashscreen.dart';

void main() {
  runApp(
    const TimerApp(),
  );
}

class TimerApp extends StatelessWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.splashScreen: (context) => const SplashScreen(),
        Routes.clockPage: (context) => const ClockPage(),
      },
    );
  }
}
