import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hakibah/components/appbar.dart';
import 'package:hakibah/constatns.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppbarHome(title: "Search"),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          child: Column(
            children: [
              Container(
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
              )
            ],
          ),
        ));
  }
}
