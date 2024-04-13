import 'package:flutter/material.dart';
import 'package:hakibah/components/appbar.dart';
import 'package:hakibah/components/carousel_slider.dart';
import 'package:hakibah/components/category_slider.dart';
import 'package:hakibah/components/popular_slider.dart';
import 'package:hakibah/components/slider.dart';
import 'package:hakibah/constatns.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> sliderImages = [
      "https://picsum.photos/1000/300?random=1",
      "https://picsum.photos/1000/300?random=1",
      "https://picsum.photos/1000/300?random=1",
      "https://picsum.photos/1000/300?random=1",
      "https://picsum.photos/1000/300?random=1",
      "https://picsum.photos/1000/300?random=1",
      "https://picsum.photos/1000/300?random=1",
      "https://picsum.photos/1000/300?random=1",
      "https://picsum.photos/1000/300?random=1",
      "https://picsum.photos/1000/300?random=1"
    ];
    const educationCategories = [
      {
        "name": "Early Childhood Education",
        "image": "https://picsum.photos/200/300?random=1"
      },
      {
        "name": "Educational Psychology",
        "image": "https://picsum.photos/200/300?random=1"
      },
      {
        "name": "Curriculum Design and Development",
        "image": "https://picsum.photos/200/300?random=1"
      },
      {
        "name": "Teaching Methods and Strategies",
        "image": "https://picsum.photos/200/300?random=1"
      },
      {
        "name": "Classroom Management",
        "image": "https://picsum.photos/200/300?random=1"
      },
      {
        "name": "Assessment and Evaluation",
        "image": "https://picsum.photos/200/300?random=1"
      },
      {
        "name": "Special Education",
        "image": "https://picsum.photos/200/300?random=1"
      },
      {
        "name": "Literacy and Reading Instruction",
        "image": "https://picsum.photos/200/300?random=1"
      },
      {
        "name": "Mathematics Education",
        "image": "https://picsum.photos/200/300?random=1"
      },
      {
        "name": "Science Education",
        "image": "https://picsum.photos/200/300?random=1"
      },
      {
        "name": "Technology Integration in Education",
        "image": "https://picsum.photos/200/300?random=1"
      },
      {
        "name": "Language Learning and Teaching",
        "image": "https://picsum.photos/200/300?random=1"
      },
      {
        "name": "Educational Leadership and Administration",
        "image": "https://picsum.photos/200/300?random=1"
      },
      {
        "name": "Educational Research Methods",
        "image": "https://picsum.photos/200/300?random=1"
      },
      {
        "name": "Multicultural Education",
        "image": "https://picsum.photos/200/300?random=1"
      }
    ];

    return Scaffold(
      appBar: const AppbarHome(title: "Home"),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSliderWidget(
                    mainPosterImagesLink: sliderImages,
                    height: 148,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const SliderNormal(categories: educationCategories),
                  const SizedBox(
                    height: 24,
                  ),
                  Divider(
                    color: blackColor.withOpacity(0.1),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const CategorySlider(categories: educationCategories),
                  const SizedBox(
                    height: 24,
                  ),
                  const PopularSlider(categories: educationCategories),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
