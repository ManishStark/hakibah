import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hakibah/components/appbar.dart';
import 'package:hakibah/components/carousel_slider.dart';
import 'package:hakibah/components/category_slider.dart';
import 'package:hakibah/components/drawer_menu.dart';
import 'package:hakibah/components/search.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/provider/categories.dart';
import 'package:hakibah/provider/popular_provider.dart';
import 'package:hakibah/provider/recent_provider.dart';
import 'package:hakibah/provider/user_provider.dart';
import 'package:hakibah/screens/add_document.dart';
import 'package:hakibah/screens/new_view_documents.dart';
import 'package:hakibah/screens/view_documents.dart';
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
  dynamic recentDocuments = {};
  dynamic popularDocuments = {};
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
    popularDocuments = ref.watch(popularProvider);
    recentDocuments = ref.watch(recentProvider);
    return Scaffold(
      appBar: const AppbarHome(
        title: "Home",
        isBackButton: false,
      ),
      drawer: const HomeDrawer(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                // const Search(),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const CarouselSliderWidget(),
                        const SizedBox(
                          height: 30,
                        ),
                        CategorySlider(categories: categories),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Recent Documents",
                              style: TextStyle(
                                  color: blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        if (recentDocuments != null)
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: recentDocuments.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    //             .toString())))
                                    goToNewScreen(
                                        context,
                                        NewViewDocumentScreen(
                                            id: recentDocuments[index]["id"]
                                                .toString()));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.all(4),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 90,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                  color: secondaryColor,
                                                  border: Border.all(
                                                      color: secondaryColor,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Image.asset(
                                                "assets/images/logo.png",
                                                height: 50,
                                                width: 50,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  recentDocuments[index]
                                                      ["title"],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  "by: ${recentDocuments[index]["user"]["first_name"]}",
                                                  style: const TextStyle(
                                                      color: Color(0xffA1A1A1),
                                                      fontSize: 14,
                                                      height: 12 / 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Divider(
                                          color: Color(0xffe5e5e5),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Positioned(
          //   bottom: 30.0,
          //   right: 16.0,
          //   child: FloatingActionButton(
          //     backgroundColor: primaryColor,
          //     onPressed: () {
          //       goToNewScreen(context, const AddDocument());
          //     },
          //     child: Icon(
          //       Icons.upload,
          //       color: whiteColor,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  void startUpApiCall() async {
    // getUserApi(ref, context);
    await getCategories(ref, context);
    if (mounted) await getStudyList(ref, context);
    if (mounted) await getPopularDocuments(ref, context);
    if (mounted) await getRecentDocuments(ref, context);
  }
}
