import 'dart:convert';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hakibah/components/appbar.dart';
import 'package:hakibah/components/drawer_menu.dart';
import 'package:hakibah/components/no_internet.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/provider/study_list_provider.dart';
import 'package:hakibah/provider/user_provider.dart';
import 'package:hakibah/utils/api_client.dart';
import 'package:hakibah/utils/reusable.dart';
import 'package:hakibah/utils/reusable_api.dart';

class ViewDocumentScreen extends ConsumerStatefulWidget {
  final String id;
  const ViewDocumentScreen({required this.id, super.key});

  @override
  ConsumerState<ViewDocumentScreen> createState() => _ViewDocumentScreenState();
}

class _ViewDocumentScreenState extends ConsumerState<ViewDocumentScreen> {
  dynamic document = {};
  bool isLoading = false;
  bool isUpdating = false;
  bool isInternet = true;
  dynamic user = {};
  dynamic wholeStudyList = [];
  bool isSaving = false;
  @override
  void initState() {
    checkConnectivity();
    getDocumentApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = ref.watch(userProvider);
    wholeStudyList = ref.watch(studyListProvider);
    return Scaffold(
      appBar: const AppbarHome(title: "View Docuement"),
      drawer: const HomeDrawer(),
      body: Stack(
        children: [
          if (!isLoading && isInternet)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showDetails("Title", document["title"] ?? ""),
                    showDetails(
                        "Category", document["category"]["title"] ?? ""),
                    showDetails(
                        "University", document["university"]["name"] ?? ""),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "http://thinkdream.in/hakibah_new/public/images/${document["image"]}",
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/images/logo.png",
                              height: 250,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            );
                          },
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: BouncingWidget(
                        onPressed: () {
                          showAddToStudyDialog(wholeStudyList);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: secondaryColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: primaryColor,
                                child: Icon(
                                  Icons.add,
                                  size: 15,
                                  color: whiteColor,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("Add To Study List"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    showDetails("Owner Name", document["category"]["title"]),
                    showDetails("Total View", document["category"]["title"]),
                    const Text(
                      "Your Rating :",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    RatingBar.builder(
                      initialRating: (document != null &&
                              document["rating"] != null &&
                              document["rating"]["rating"] != null)
                          ? double.parse(
                              document["rating"]["rating"].toString())
                          : 0.0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star_border_rounded,
                        color: Colors.amber,
                        size: 15,
                      ),
                      onRatingUpdate: (rating) {
                        addRating(rating.toString());
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Center(child: customButton(title: "Download", height: 40)),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          if (isLoading)
            Center(
              child: loadingSpinner(),
            ),
          if (!isLoading && !isInternet)
            NoInternet(onRetryPressed: () async {
              isInternet = await checkConnectivity();
              if (isInternet) {
                getDocumentApiCall();
              } else {
                if (!context.mounted) return;
                showAlert(context, noInternetString, "error");
              }
            }),
          if (isUpdating || isSaving)
            Center(
              child: loadingSpinner(),
            )
        ],
      ),
    );
  }

  void getDocumentApiCall() async {
    setState(() {
      isLoading = true;
    });
    try {
      var response = await apiClient(
          apiEndpoint: "single-document/${widget.id}", context: context);
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        if (decode["code"] == 200) {
          document = decode["data"];
          setState(() {});
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

  void checkInternet() async {
    isInternet = await checkConnectivity();
    setState(() {});
  }

  Widget showDetails(String title, String data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title :",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            data,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  void addRating(String rating) async {
    isUpdating = true;

    try {
      Map<String, dynamic> requestBody = {
        "user_id": user["id"].toString(),
        "document_id": widget.id,
        "rating": rating,
      };
      var response = await apiClient(
          apiEndpoint: "rating-document",
          context: context,
          method: "POST",
          requestBody: requestBody);
      if (response.statusCode == 200) {
        var decode = await jsonDecode(response.body);
        if (!mounted) return;
        if (decode["code"] == 200) {
          showAlert(context, "success", "success");
        } else {
          showAlert(context, "failed to rate..", "error");
        }
      } else {
        if (!mounted) return;
        showAlert(context, "failed to rate..", "error");
      }
      setState(() {
        isUpdating = false;
      });
    } catch (e) {
      setState(() {
        isUpdating = false;
        showAlert(context, "failed to rate..", "error");
      });
    }
  }

  void showAddToStudyDialog(List<dynamic> wholeStudyList) {
    List<dynamic> studyList = [
      {"title": "- Select StudyList -"}
    ];
    setState(() {
      studyList.addAll(wholeStudyList);
    });
    String studyValue = "- Select StudyList -";
    dynamic setStudyValue = {};
    bool showStudyField = false;
    String studyName = "";
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16),
          shape: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Add To Study List ",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.7),
                        border: Border.all(color: secondaryColor, width: 1)),
                    child: DropdownButton<dynamic>(
                      value: studyValue,
                      isDense: true,
                      isExpanded: true,
                      underline: Container(),
                      style: TextStyle(color: blackColor),
                      onChanged: (dynamic newValue) {
                        setState(() {
                          studyValue = newValue!;
                        });
                      },
                      items: studyList
                          .map<DropdownMenuItem<dynamic>>((dynamic study) {
                        return DropdownMenuItem<String>(
                          onTap: () {
                            setState(() {
                              setStudyValue = study;
                            });
                          },
                          value: study['title'],
                          child: Text(
                            study['title'],
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showStudyField = !showStudyField;
                      });
                    },
                    child: Container(
                      width: 165,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(8.7)),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: whiteColor,
                            child: Icon(
                              Icons.add,
                              size: 15,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            "Create Study List",
                            style: TextStyle(
                                color: whiteColor, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (showStudyField)
                    TextFormField(
                      onChanged: (val) {
                        studyName = val;
                        setState(() {
                          studyName = val;
                        });
                      },
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          hintText: "enter study list name...",
                          hintStyle: TextStyle(
                              fontSize: 14, color: blackColor.withOpacity(0.5)),
                          prefixIcon: const Icon(
                            Icons.edit,
                            size: 20,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  if (showStudyField)
                    const SizedBox(
                      height: 12,
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: BouncingWidget(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.red[400],
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Close",
                              style: TextStyle(color: whiteColor),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: BouncingWidget(
                          onPressed: () {
                            if (setStudyValue.isEmpty) {
                              showAlert(context, "please select study list...",
                                  "error");
                              return;
                            }
                            Navigator.pop(context);

                            if (studyName.isNotEmpty) {
                              saveStudyList(
                                  studyName, document["id"].toString());
                            } else {
                              saveDocumentToStudyList(document["id"].toString(),
                                  setStudyValue["id"].toString());
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Save",
                              style: TextStyle(color: whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }

  void saveStudyList(String studyName, String docId) async {
    try {
      setState(
        () {
          isSaving = true;
        },
      );
      Map<String, dynamic> requestBody = {
        "name": studyName,
      };

      var response = await apiClient(
          apiEndpoint: "create-study-list",
          requestBody: requestBody,
          method: "POST",
          context: context);
      if (response.statusCode == 200) {
        var decode = await jsonDecode(response.body);
        if (decode["code"] == 200) {
          if (!mounted) return;
          getStudyList(ref, context);
          saveDocumentToStudyList(docId, decode["data"]["id"].toString());
        } else {
          if (!mounted) return;
          setState(() {
            isSaving = false;
          });
          showAlert(context, "failed to create study list", "error");
        }
      } else {
        if (!mounted) return;
        setState(() {
          isSaving = false;
        });
        showAlert(context, "failed to create study list", "error");
      }
    } catch (e) {
      setState(() {
        isSaving = false;
      });
      showAlert(context, "failed to create study list", "error");
    }
  }

  void saveDocumentToStudyList(String docId, String studyListId) async {
    try {
      setState(
        () {
          isSaving = true;
        },
      );
      Map<String, dynamic> requestBody = {
        "user_id": user["id"],
        "document_id": docId,
        "study_list_id": studyListId,
      };

      var response = await apiClient(
          apiEndpoint: "add-document-to-study-list",
          requestBody: requestBody,
          method: "POST",
          context: context);
      if (response.statusCode == 200) {
        var decode = await jsonDecode(response.body);
        if (decode["code"] == 200) {
          if (!mounted) return;
          showAlert(context, "document added to study list...", "success");
        } else {
          if (!mounted) return;

          showAlert(context, "failed to add document to study list", "error");
        }
      } else {
        if (!mounted) return;

        showAlert(context, "failed to add document to study list", "error");
      }

      setState(() {
        isSaving = false;
      });
    } catch (e) {
      setState(() {
        isSaving = false;
      });
      showAlert(context, "failed to add document to study list", "error");
    }
  }
}
