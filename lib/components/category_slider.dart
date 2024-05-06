import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/screens/categories_screen.dart';
import 'package:hakibah/screens/document_list.dart';
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
                child: Text(
                  "See All",
                  style: TextStyle(
                      color: primaryColor,
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
        if (mounted) {
          goToNewScreen(
              context,
              DocumentListScreen(
                catId: item["id"].toString(),
                title: item["title"],
              ));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
          color: primaryColor,
          boxShadow: boxShadow,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          item["title"],
          style: TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
