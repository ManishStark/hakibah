import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hakibah/constatns.dart';

class AppbarHome extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButton;
  final bool isStudyButton;
  final Function()? addStudy;
  const AppbarHome(
      {required this.title,
      this.isBackButton = true,
      this.isStudyButton = false,
      this.addStudy,
      super.key});

  @override
  State<AppbarHome> createState() => _AppbarHomeState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _AppbarHomeState extends State<AppbarHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: AppBar(
        surfaceTintColor: whiteColor,
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            if (widget.isBackButton)
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset("assets/icons/back_button.svg"),
              ),
            if (widget.isBackButton)
              const SizedBox(
                width: 12,
              ),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          if (widget.isStudyButton)
            GestureDetector(
              onTap: widget.addStudy,
              child: const Icon(Icons.add),
            ),
          if (widget.isStudyButton)
            const SizedBox(
              width: 16,
            ),
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: const Icon(Icons.menu),
          )
        ],
      ),
    );
  }
}
