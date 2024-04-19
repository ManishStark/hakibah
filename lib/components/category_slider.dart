import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/screens/categories_screen.dart';
import 'package:hakibah/utils/reusable.dart';

class CategorySlider extends ConsumerStatefulWidget {
  final dynamic categories;
  const CategorySlider({required this.categories, super.key});

  @override
  ConsumerState<CategorySlider> createState() => _CategorySliderState();
}

class _CategorySliderState extends ConsumerState<CategorySlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Categories",
              style: TextStyle(
                  color: blackColor, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            GestureDetector(
              onTap: () {
                goToNewScreen(
                    context,
                    const CategoryScreen(
                      isBackButton: true,
                    ));
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "See All",
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        SingleChildScrollView(
          controller: ScrollController(),
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.categories != null)
                  for (dynamic item in widget.categories) categoryWidget(item)
              ]),
        ),
      ],
    );
  }

  Widget categoryWidget(dynamic item) {
    return GestureDetector(
      onTap: () async {
        var isNetworkAvailable = await checkConnectivity();
        if (!isNetworkAvailable) {
          if (context.mounted) {
            if (!mounted) return;
            showAlert(context, noInternetString, "error");
          }
          return;
        }
        if (mounted) {}
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
            // boxShadow: boxShadow,
            color: whiteColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: secondaryColor)),
        child: Text(
          item["title"],
          style: TextStyle(
              color: blackColor, fontWeight: FontWeight.w400, fontSize: 14),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
