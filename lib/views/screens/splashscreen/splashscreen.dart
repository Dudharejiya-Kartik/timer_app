import 'dart:async';

import 'package:flutter/material.dart';

import '../../../utills/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAnimated = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 5),
      () {
        isAnimated = false;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 6),
      () {
        Navigator.of(context).pushReplacementNamed(Routes.clockPage);
      },
    );
    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(seconds: 4),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          child: (isAnimated)
              ? Image(
                  key: UniqueKey(),
                  image: NetworkImage(
                      "https://i.pinimg.com/474x/ae/fe/70/aefe701e50855d7fd50f92f666a4e1e8.jpg"),
                  height: 200,
                )
              : Image(
                  key: UniqueKey(),
                  image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsBG7TCjiJNpSTbISm5vafjgns2ULT2xFgbbgW1iAyDg&s"),
                ),
        ),
      ),
    );
  }
}
