import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hakibah/constatns.dart';

class PopularSlider extends ConsumerStatefulWidget {
  final dynamic categories;
  const PopularSlider({required this.categories, super.key});

  @override
  ConsumerState<PopularSlider> createState() => _SliderState();
}

class _SliderState extends ConsumerState<PopularSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Most Popular",
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
          child: Column(
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
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              item["title"],
              style: TextStyle(
                  color: blackColor, fontWeight: FontWeight.w400, fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
