import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hakibah/components/appbar.dart';
import 'package:hakibah/components/drawer_menu.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/provider/study_list_provider.dart';
import 'package:hakibah/utils/api_client.dart';
import 'package:hakibah/utils/reusable.dart';

class StudyListScreen extends ConsumerStatefulWidget {
  const StudyListScreen({super.key});

  @override
  ConsumerState<StudyListScreen> createState() => _StudyListScreenState();
}

class _StudyListScreenState extends ConsumerState<StudyListScreen> {
  bool isLoading = false;
  dynamic studyList = [];

  @override
  Widget build(BuildContext context) {
    studyList = ref.watch(studyListProvider);

    return Scaffold(
      appBar: AppbarHome(
        title: "Study List",
        isStudyButton: true,
        addStudy: addStudyDialog,
      ),
      drawer: const HomeDrawer(),
      body: Stack(
        children: [
          if (studyList.isNotEmpty)
            SizedBox(
              child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
                  itemCount: studyList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: secondaryColor),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        studyList[index]["title"],
                        style: TextStyle(fontSize: 16, color: blackColor),
                      ),
                    );
                  }),
            )
        ],
      ),
    );
  }

  void getStudyListApicall() async {
    try {
      setState(() {
        isLoading = true;
      });
      var response =
          await apiClient(apiEndpoint: "list-study-list", context: context);
      if (response.statusCode == 200) {
        var decode = await jsonDecode(response.body);
        if (decode["code"] == 200) {
          studyList.addAll(decode["data"]);
        } else {
          if (!mounted) return;
          showAlert(context, "failed to load study list", "error");
        }
      } else {
        if (!mounted) return;
        showAlert(context, "failed to load study list", "error");
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      showAlert(context, "failed to load study list", "error");
    }
  }

  void addStudyDialog() {
    String studyList = "";
    bool isStudyLoading = false;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              content: SizedBox(
                height: 150,
                child: Column(
                  children: [
                    const Text(
                      "Add New Study List",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "enter study list name"),
                      onChanged: (value) {
                        studyList = value;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (studyList.isEmpty) {
                          showAlert(
                              context, "please enter study list name", "error");
                          return;
                        }
                        try {
                          setState(
                            () {
                              isStudyLoading = true;
                            },
                          );
                          Map<String, dynamic> requestBody = {
                            "name": studyList,
                          };

                          var response = await apiClient(
                              apiEndpoint: "create-study-list",
                              requestBody: requestBody,
                              method: "POST",
                              context: context);
                          if (response.statusCode == 200) {
                            var decode = await jsonDecode(response.body);
                            if (decode["code"] == 200) {
                              if (!context.mounted) return;
                              showAlert(
                                  context, "Study list created...", "success");
                              Navigator.pop(context);
                            } else {
                              if (!context.mounted) return;

                              showAlert(context,
                                  "failed to11 create study list", "error");
                            }
                          } else {
                            if (!context.mounted) return;

                            showAlert(context, "failed to create study list",
                                "error");
                          }

                          setState(() {
                            isStudyLoading = false;
                          });
                        } catch (e) {
                          setState(() {
                            isStudyLoading = false;
                          });
                          showAlert(
                              context, "failed to create study list", "error");
                        }
                      },
                      child: customButton(
                        title: isStudyLoading ? "Creating..." : "Create",
                        height: 35,
                        width: 150,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
