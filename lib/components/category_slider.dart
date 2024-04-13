import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hakibah/constatns.dart';

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
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10)),
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
            showAlert(context, noInternetString, "error");
          }
          return;
        }
        if (mounted) {}
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 90,
              width: 150,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  item["image"],
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 150,
              decoration: BoxDecoration(color: whiteColor),
              child: Text(
                item["name"],
                style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
