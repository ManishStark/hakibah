import 'dart:convert';

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:hakibah/components/appbar.dart';
import 'package:hakibah/components/document_card.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/utils/api_client.dart';
import 'package:hakibah/utils/reusable.dart';
import 'package:lottie/lottie.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class DocumentListScreen extends StatefulWidget {
  final String catId;
  final String title;
  const DocumentListScreen(
      {required this.catId, required this.title, super.key});

  @override
  State<DocumentListScreen> createState() => _DocumentListScreenState();
}

class _DocumentListScreenState extends State<DocumentListScreen> {
  bool isLoading = false;
  dynamic documentsList = [];
  bool noData = false;
  @override
  void initState() {
    getDocumentsApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarHome(
        title: widget.title.isNotEmpty ? widget.title : "",
      ),
      body: Stack(
        children: [
          if (documentsList.isNotEmpty)
            LiveGrid(
              visibleFraction: 0.1,
              reAnimateOnVisibility: false,
              addRepaintBoundaries: false,
              // controller: _scrollController,
              showItemInterval: const Duration(milliseconds: 50),
              showItemDuration: const Duration(milliseconds: 400),
              // visibleFraction: 0.001,
              itemCount: documentsList.length,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 170,
              ),
              itemBuilder: animationItemBuilder(
                (index) => DocumentCard(document: documentsList[index]),
              ),
            ),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          //   child: GridView.builder(
          //       itemCount: documentsList.length,
          //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 2,
          //           crossAxisSpacing: 16,
          //           mainAxisExtent: 170,
          //           mainAxisSpacing: 16),
          //       itemBuilder: (context, index) {
          //         return DocumentCard(document: documentsList[index]);
          //       }),
          // ),
          if (!isLoading && noData) noItemFound(),
          if (isLoading)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
              child: SingleChildScrollView(
                child: SkeletonGridLoader(
                  builder: Card(
                    elevation: 0,
                    semanticContainer: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11.064),
                    ),
                    // surfaceTintColor: const Color(0xffFBF8F8),
                    // color: const Color(0xffFBF8F8),
                    child: GridTile(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 50,
                            height: 10,
                            color: Colors.blueAccent,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 70,
                            height: 10,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  items: 8,
                  itemsPerRow: 2,
                  period: const Duration(seconds: 2),
                  // highlightColor: const Color(0xffFBF8F8),
                  direction: SkeletonDirection.ltr,
                  childAspectRatio: 1,
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget noItemFound() {
    return LottieBuilder.asset(
      "assets/anim/no_item.json",
      width: double.infinity,
      height: 300,
    );
  }

  void getDocumentsApiCall() async {
    setState(() {
      isLoading = true;
    });
    try {
      var response = await apiClient(
          apiEndpoint: "get-by-category/${widget.catId}", context: context);
      if (response.statusCode == 200) {
        var decode = await jsonDecode(response.body);
        if (decode["code"] == 200) {
          setState(() {
            documentsList = decode["data"];
          });
        } else if (decode["code"] == 404) {
          setState(() {
            noData = true;
          });
          if (!mounted) return;
          showAlert(context, "no documents found..", "error");
        } else {
          if (!mounted) return;
          showAlert(context, "failed to get documents", "error");
        }
      } else {
        if (!mounted) return;

        showAlert(context, "failed to get documents", "error");
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        showAlert(context, "failed to get documents", "error");
      });
    }
  }
}
