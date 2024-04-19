import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hakibah/auth/login_screen.dart';
import 'package:hakibah/components/bottom_navigation.dart';
import 'package:hakibah/constatns.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () async {
      String token = await getToken();
      if (mounted) {
        if (!context.mounted) return;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => token.isEmpty
                ? const LoginScreen()
                : const PresistantNavbar()));
      }
    });
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          height: 250,
          width: 250,
        ),
      ),
    );
  }
}
