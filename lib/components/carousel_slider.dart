import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hakibah/constatns.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselSliderWidget extends StatefulWidget {
  final double height;
  final List<String> mainPosterImagesLink;

  const CarouselSliderWidget(
      {required this.height, required this.mainPosterImagesLink, super.key});

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  int activeIndex = 0;
  final controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      Column(children: [
        CarouselSlider.builder(
          carouselController: controller,
          itemCount: widget.mainPosterImagesLink.length,
          itemBuilder: (context, index, itemCount) {
            while (true) {
              var displayImg = widget.mainPosterImagesLink[index];
              return buildImage(displayImg, index, widget.height);
            }
          },
          options: CarouselOptions(
              height: widget.height,
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
      ]),
      buildIndicator(),
    ]);
  }

  Widget buildImage(String displayUrl, int indx, double height) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: (displayUrl == "none")
            ? errorWidget(height: height, width: height)
            : Image.network(
                displayUrl,
                fit: BoxFit.fill,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return errorWidget(height: height, width: height);
                },
                height: height,
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
        count: widget.mainPosterImagesLink.length,
        effect: ExpandingDotsEffect(
            dotHeight: 7,
            dotWidth: 7,
            activeDotColor: const Color(0xffF9B023),
            dotColor: primaryColor),
      );
}
