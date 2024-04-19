import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/utils/api_client.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselSliderWidget extends StatefulWidget {
  const CarouselSliderWidget({super.key});

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  int activeIndex = 0;
  final controller = CarouselController();
  final double height = 177;
  final List<dynamic> mainPosterImagesLink = [];
  bool isLoading = false;
  @override
  void initState() {
    getPopularDocuments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      if (mainPosterImagesLink.isNotEmpty)
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

  void getPopularDocuments() async {
    setState(() {
      isLoading = true;
    });
    try {
      var response = await apiClient(
          apiEndpoint: "most-populer-document", context: context);
      if (response.statusCode == 200) {
        var decode = await jsonDecode(response.body);
        if (decode["code"] == 200) {
          mainPosterImagesLink.addAll(decode["data"]);
          setState(() {});
        }
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = true;
      });
    }
  }

  Widget buildImage(dynamic item, int indx, double height) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          onTap: () {
            showAlert(context, item[indx]["id"].toString(), "success");
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
            activeDotColor: const Color(0xffF9B023),
            dotColor: primaryColor),
      );
}
