import 'package:flutter/material.dart';

class AppbarHome extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const AppbarHome({required this.title, super.key});

  @override
  State<AppbarHome> createState() => _AppbarHomeState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppbarHomeState extends State<AppbarHome> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}
