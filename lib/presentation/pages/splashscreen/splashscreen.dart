import 'dart:async';

import 'package:crashorcash/layout.dart';
import 'package:crashorcash/navigation_menu.dart';
import 'package:crashorcash/utils/helpers/user_token_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  Future<void> navigate() async {
    String initialRoute =
        await UserTokenManager.hasAccessToken() ? "/games" : "/auth";
    Timer(
        const Duration(seconds: 2),
        () => initialRoute == '/games'
            ? Get.off(() => const NavigationMenu())
            : Get.offNamed(initialRoute));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/auth-portrait-bg.png"),
                fit: BoxFit.cover)),
      ),
    );
  }
}
