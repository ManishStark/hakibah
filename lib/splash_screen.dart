import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hakibah/auth/login_screen.dart';
import 'package:hakibah/components/bottom_navigation.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/screens/select_category_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () async {
      String isInterestCategory = await getInterestCategory();
      String token = await getToken();
      if (!mounted) return;
      if (token.isNotEmpty && isInterestCategory.isNotEmpty) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const PresistantNavbar()));
      } else if (token.isNotEmpty && isInterestCategory.isEmpty) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const SelectCategoryScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () async {});
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
