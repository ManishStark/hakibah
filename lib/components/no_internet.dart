import 'package:flutter/material.dart';
import 'package:hakibah/constatns.dart';
import 'package:lottie/lottie.dart';

class NoInternet extends StatefulWidget {
  final VoidCallback onRetryPressed;
  final Color? primaryColor;
  final Color? fontColor;
  const NoInternet(
      {required this.onRetryPressed,
      this.primaryColor,
      this.fontColor,
      super.key});

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            noInternetString,
            style: TextStyle(
                color: widget.primaryColor ?? primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          Lottie.asset('lib/assets/anim/no_internet.json',
              package: "salesgent_ui_components", height: 450),

          GestureDetector(
            onTap: widget.onRetryPressed,
            child: const Text("Retry"),
          ),
          // customButton(
          //     title: "Retry",
          //     onClickFunc: widget.onRetryPressed,
          //     bgColor: widget.primaryColor,
          //     textColor: widget.fontColor,
          //     verticalSize: 12,
          //     horizontalSize: 80,
          //     fontSize: 20,
          //     borderRadius: 30),
        ],
      ),
    );
  }
}
