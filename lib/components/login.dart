import 'package:flutter/material.dart';
import 'package:hakibah/constatns.dart';
import 'package:lottie/lottie.dart';

class Login extends StatefulWidget {
  final VoidCallback onLoginPressed;
  final Color? primaryColor;
  final Color? fontColor;
  final Widget buttonWidget;
  final String title;
  const Login(
      {required this.onLoginPressed,
      this.primaryColor,
      this.fontColor,
      required this.buttonWidget,
      this.title = "Please login to access.",
      super.key});

  @override
  State<Login> createState() => _NoInternetState();
}

class _NoInternetState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            widget.title,
            style: TextStyle(
                color: widget.primaryColor ?? primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          Lottie.asset('lib/assets/anim/login.json',
              package: "salesgent_ui_components", height: 450),
          GestureDetector(
            onTap: widget.onLoginPressed,
            child: widget.buttonWidget,
          )
        ],
      ),
    );
  }
}
