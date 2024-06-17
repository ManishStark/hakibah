import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/provider/popular_provider.dart';
import 'package:hakibah/screens/view_documents.dart';
import 'package:hakibah/utils/reusable.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselSliderWidget extends ConsumerStatefulWidget {
  const CarouselSliderWidget({super.key});

  @override
  ConsumerState<CarouselSliderWidget> createState() =>
      _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends ConsumerState<CarouselSliderWidget> {
  int activeIndex = 0;
  final controller = CarouselController();
  final double height = 200;
  dynamic mainPosterImagesLink = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mainPosterImagesLink = ref.watch(popularProvider);
    print("Popuilar--->$mainPosterImagesLink");
    return Stack(children: [
      if (mainPosterImagesLink != null && mainPosterImagesLink.isNotEmpty)
        Column(children: [
          CarouselSlider.builder(
            carouselController: controller,
            itemCount: mainPosterImagesLink.length,
            itemBuilder: (context, index, itemCount) {
              while (true) {
                return buildImage(mainPosterImagesLink, index, height);
              }
            },
            options: CarouselOptions(
                height: height,
                clipBehavior: Clip.hardEdge,
                viewportFraction: 1,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 300),
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index)),
          ),
          const SizedBox(
            height: 20,
          ),
          buildIndicator(),
        ]),
      if (isLoading)
        Center(
          child: loadingDots(),
        )
    ]);
  }

  Widget buildImage(dynamic item, int indx, double height) {
    return GestureDetector(
      onTap: () {
        goToNewScreen(
            context, ViewDocumentScreen(id: item[indx]["id"].toString()));
      },
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
            color: const Color(0xffEEEEEE),
            borderRadius: BorderRadius.circular(10)),
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "http://thinkdream.in/hakibah_new/public/images/${mainPosterImagesLink[indx]["image"]}",
                fit: BoxFit.fill,
                width: double.infinity,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return errorWidget(height: height, width: height);
                },
                height: height,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  item[indx]["title"],
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 20,
                      height: 26 / 20,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "by: ${item[indx]["user"]["first_name"]}",
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 14,
                      height: 12 / 14,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                width: 150,
                height: 35,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                    color: whiteColor, borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    "Start Learning",
                    style: TextStyle(
                        fontSize: 14,
                        color: blackColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )),
        ]),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        onDotClicked: (index) {
          activeIndex = index;
          controller.animateToPage(index);
          controller.jumpToPage(index);
          setState(() {});
        },
        count: mainPosterImagesLink.length,
        effect: ExpandingDotsEffect(
            dotHeight: 7,
            dotWidth: 7,
            activeDotColor: primaryColor,
            dotColor: secondaryColor),
      );
}
