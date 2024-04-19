import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hakibah/components/appbar.dart';
import 'package:hakibah/components/carousel_slider.dart';
import 'package:hakibah/components/category_slider.dart';
import 'package:hakibah/components/drawer_menu.dart';
import 'package:hakibah/components/popular_slider.dart';
import 'package:hakibah/provider/categories.dart';
import 'package:hakibah/provider/user_provider.dart';
import 'package:hakibah/screens/add_document.dart';
import 'package:hakibah/utils/reusable.dart';
import 'package:hakibah/utils/reusable_api.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  dynamic categories = [];
  dynamic user = {};
  List<Widget> topDocuments = [];
  @override
  void initState() {
    startUpApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    categories = ref.watch(categoriesProvider);
    user = ref.watch(userProvider);
    print(user);
    return Scaffold(
      appBar: const AppbarHome(
        title: "Home",
        isBackButton: false,
      ),
      drawer: const HomeDrawer(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSliderWidget(),
                  CategorySlider(categories: categories),
                  const SizedBox(
                    height: 26,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 70.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                goToNewScreen(context, const AddDocument());
              },
              child: const Icon(Icons.upload),
            ),
          ),
        ],
      ),
    );
  }

  void startUpApiCall() async {
    // getUserApi(ref, context);
    await getCategories(ref, context);
  }
}
