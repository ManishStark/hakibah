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
        if (widget.categories != null && widget.categories.length > 0)
          SizedBox(
            height: 205,
            width: double.infinity,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.categories.length,
                itemBuilder: (context, index) {
                  return categoryWidget(widget.categories[index], index);
                }),
          )
        // SingleChildScrollView(
        //   controller: ScrollController(),
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         if (widget.categories != null)
        //           for (dynamic item in widget.categories) categoryWidget(item)
        //       ]),
        // ),
      ],
    );
  }

  Widget categoryWidget(dynamic item, int index) {
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
          // height: 150,
          width: 210,
          margin: const EdgeInsets.only(right: 16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xffEEEEEE),
                    borderRadius: BorderRadius.circular(10)),
                child: item["image"] != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          item["image"],
                          errorBuilder: (context, error, stackTrace) {
                            return errorWidget(
                              height: 150,
                              width: 200,
                            );
                          },
                          height: 150,
                          width: 200,
                          fit: BoxFit.contain,
                        ),
                      )
                    : errorWidget(
                        height: 150,
                        width: 200,
                      ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(children: [
                CircleAvatar(
                  backgroundColor: primaryColor,
                  child: Text(
                    index.toString(),
                    style: TextStyle(color: whiteColor),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      item["title"],
                      style: TextStyle(
                        color: blackColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ]),
            ],
          )),
    );
  }
}
