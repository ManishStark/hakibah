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
  final double height = 177;
  dynamic mainPosterImagesLink = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mainPosterImagesLink = ref.watch(popularProvider);
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

  Widget buildImage(dynamic item, int indx, double height) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          onTap: () {
            goToNewScreen(
                context, ViewDocumentScreen(id: item[indx]["id"].toString()));
          },
          child: Image.network(
            "http://thinkdream.in/hakibah_new/public/images/${mainPosterImagesLink[indx]["image"]}",
            fit: BoxFit.fill,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return errorWidget(height: height, width: height);
            },
            height: height,
          ),
        ),
      );
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
