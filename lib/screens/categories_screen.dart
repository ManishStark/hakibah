import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hakibah/components/appbar.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/provider/categories.dart';
import 'package:hakibah/utils/reusable_api.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  final bool? isBackButton;
  const CategoryScreen({this.isBackButton, super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  dynamic categories = [];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    categories = ref.watch(categoriesProvider);
    if (categories == null) {
      getCategoriesApiCall();
    }

    return Scaffold(
      appBar: AppbarHome(
        title: "Categories",
        isBackButton: widget.isBackButton ?? false,
      ),
      body: Stack(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
          child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (contex, index) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: secondaryColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(categories[index]["title"]),
                    ],
                  ),
                );
              }),
        ),
        if (isLoading)
          Center(
            child: loadingSpinner(color: primaryColor),
          )
      ]),
    );
  }

  void getCategoriesApiCall() async {
    setState(() {
      isLoading = true;
    });
    try {
      await getCategories(ref, context);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }
}
