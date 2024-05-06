import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/screens/search_screen.dart';
import 'package:hakibah/utils/reusable.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        goToNewScreen(context, const SearchScreen());
      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(color: secondaryColor, width: 1),
            borderRadius: BorderRadius.circular(8.7)),
        child: Row(
          children: [
            SvgPicture.asset("assets/icons/search.svg"),
            const SizedBox(
              width: 13,
            ),
            Text(
              "Search for courses, books or documents...",
              style: TextStyle(color: blackColor.withOpacity(0.5)),
            )
          ],
        ),
      ),
    );
  }
}
