import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hakibah/constatns.dart';

class SliderNormal extends ConsumerStatefulWidget {
  final dynamic categories;
  const SliderNormal({required this.categories, super.key});

  @override
  ConsumerState<SliderNormal> createState() => _SliderState();
}

class _SliderState extends ConsumerState<SliderNormal> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      scrollDirection: Axis.horizontal,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.categories != null)
              for (dynamic item in widget.categories) categoryWidget(item)
          ]),
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  item["image"],
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
