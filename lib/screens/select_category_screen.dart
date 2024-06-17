import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hakibah/components/appbar.dart';
import 'package:hakibah/components/bottom_navigation.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/provider/categories.dart';
import 'package:hakibah/provider/user_provider.dart';
import 'package:hakibah/utils/api_client.dart';
import 'package:hakibah/utils/reusable.dart';
import 'package:hakibah/utils/reusable_api.dart';

class SelectCategoryScreen extends ConsumerStatefulWidget {
  const SelectCategoryScreen({super.key});

  @override
  ConsumerState<SelectCategoryScreen> createState() =>
      _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends ConsumerState<SelectCategoryScreen> {
  bool isLoading = false;
  dynamic categories = [];
  List<dynamic> selectedCategories = [];
  bool isSaving = false;
  dynamic user = {};

  @override
  Widget build(BuildContext context) {
    categories = ref.watch(categoriesProvider);
    user = ref.watch(userProvider);
    if (categories == null) {
      getCategoriesApiCall();
    }
    return Scaffold(
        appBar: const AppbarHome(
          title: "Select Interest",
          isMenu: false,
        ),
        body: Stack(
          children: [
            if (!isLoading)
              Column(
                children: [
                  if (categories != null && categories.isNotEmpty)
                    Expanded(
                      child: GridView.builder(
                          itemCount: categories.length,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 26, vertical: 16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20),
                          itemBuilder: (context, index) {
                            return cartItem(categories[index]);
                          }),
                    ),
                  GestureDetector(
                    onTap: () {
                      if (selectedCategories.isEmpty) {
                        showAlert(
                            context,
                            "select atleast one interested category..",
                            "error");
                        return;
                      }
                      saveInterestedCategories();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 26, vertical: 16),
                      child: customButton(
                          title: "Continue", width: double.infinity),
                    ),
                  ),
                ],
              ),
            if (isLoading)
              Center(
                child: loadingSpinner(color: primaryColor),
              ),
            if (isSaving)
              Center(
                child: loadingSpinner(color: primaryColor),
              ),
          ],
        ));
  }

  Widget cartItem(dynamic item) {
    bool isSelected = selectedCategories.contains(item["id"]);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedCategories.remove(item["id"]);
          } else {
            selectedCategories.add(item["id"]);
          }
        });
      },
      child: Container(
          decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xff373737)
                  : const Color(0xffEBF3EF),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              item["image"] != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        item["image"],
                        errorBuilder: (context, error, stackTrace) {
                          return errorWidget(
                            height: 80,
                            width: 80,
                          );
                        },
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    )
                  : errorWidget(
                      height: 80,
                      width: 80,
                    ),
              const SizedBox(
                height: 8,
              ),
              Text(
                item["title"],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? whiteColor : blackColor,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          )),
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

  void saveInterestedCategories() async {
    setState(() {
      isSaving = true;
    });

    try {
      Map<String, dynamic> requestBody = {
        "user_id": user["id"].toString(),
        "category_id": selectedCategories,
      };
      var response = await apiClient(
          apiEndpoint: "save-intrest-category",
          context: context,
          method: "POST",
          requestBody: requestBody);
      if (response.statusCode == 200) {
        await setInterestCategory("yes");
        if (!mounted) return;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const PresistantNavbar()));
      } else {
        if (!mounted) return;
        showAlert(context, "failed to save interested category..", "error");
      }
      setState(() {
        isSaving = false;
      });
    } catch (e) {
      setState(() {
        isSaving = false;
        showAlert(context, "failed to save interested category..", "error");
      });
    }
  }
}
