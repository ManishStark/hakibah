import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_searchable_dropdown/flutter_searchable_dropdown.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hakibah/components/appbar.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/utils/api_client.dart';

class AddDocument extends StatefulWidget {
  const AddDocument({super.key});

  @override
  State<AddDocument> createState() => _AddDocumentState();
}

class _AddDocumentState extends State<AddDocument> {
  List<dynamic> categories = [
    {"title": "- Select Category -"}
  ];
  String categoryValue = "- Select Category -";
  List<dynamic> types = [
    {"title": "- Select Type -"}
  ];
  String typeValue = "- Select Type -";

  var universities = [];
  var universitiesCopy = [];
  String title = "";
  @override
  void initState() {
    getCategoryApiCall();
    getTypeApiCall();
    getUniversityApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarHome(title: "Add Document"),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: SingleChildScrollView(
              child: Column(children: [
                if (categories.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        boxShadow: boxShadow,
                        borderRadius: BorderRadius.circular(8.7),
                        border: Border.all(width: 1, color: secondaryColor)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Category : ",
                          style: TextStyle(
                              color: blackColor, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButton<dynamic>(
                          value: categoryValue,
                          isDense: true,
                          underline: Container(),
                          style: TextStyle(color: blackColor),
                          onChanged: (dynamic newValue) {
                            setState(() {
                              categoryValue = newValue!;
                            });
                          },
                          items: categories.map<DropdownMenuItem<dynamic>>(
                              (dynamic category) {
                            return DropdownMenuItem<String>(
                              value: category['title'],
                              child: Text(
                                category['title'],
                                style: TextStyle(fontSize: 16),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      boxShadow: boxShadow,
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(8.7),
                      border: Border.all(width: 1, color: secondaryColor)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Title : ",
                        style: TextStyle(
                            color: blackColor, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      textFormFieldApp(
                          name: "Title",
                          textValue: title,
                          onValueChanged: (value) {
                            title = value;
                            setState(() {});
                          })
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                if (types.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        boxShadow: boxShadow,
                        borderRadius: BorderRadius.circular(8.7),
                        border: Border.all(width: 1, color: secondaryColor)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Types : ",
                          style: TextStyle(
                              color: blackColor, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButton<dynamic>(
                          value: typeValue,
                          isDense: true,
                          underline: Container(),
                          style: TextStyle(color: blackColor),
                          onChanged: (dynamic newValue) {
                            setState(() {
                              typeValue = newValue!;
                            });
                          },
                          items: types
                              .map<DropdownMenuItem<dynamic>>((dynamic type) {
                            return DropdownMenuItem<String>(
                              value: type['title'],
                              child: Text(
                                type['title'],
                                style: TextStyle(fontSize: 16),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                GestureDetector(
                  onTap: () {
                    univerityDialog(context);
                  },
                  child: Text("!"),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }

  void getCategoryApiCall() async {
    try {
      var response =
          await apiClient(apiEndpoint: "get-category", context: context);
      if (response.statusCode == 200) {
        var decode = await jsonDecode(response.body);
        if (decode["code"] == 200) {
          categories.addAll(decode["data"]);
          print(categories);
          setState(() {});
        } else {
          if (!mounted) return;
          showAlert(context, "failed to get categories", "error");
        }
      } else {
        if (!mounted) return;
        showAlert(context, "failed to get categories", "error");
      }
    } catch (e) {
      print(e);
      if (!mounted) return;
      showAlert(context, "failed to get categories", "error");
    }
  }

  void getTypeApiCall() async {
    try {
      var response =
          await apiClient(apiEndpoint: "get-types", context: context);
      if (response.statusCode == 200) {
        var decode = await jsonDecode(response.body);
        if (decode["code"] == 200) {
          types.addAll(decode["data"]);
          setState(() {});
        } else {
          if (!mounted) return;
          showAlert(context, "failed to get types", "error");
        }
      } else {
        if (!mounted) return;
        showAlert(context, "failed to get types", "error");
      }
    } catch (e) {
      if (!mounted) return;
      showAlert(context, "failed to get types", "error");
    }
  }

  void getUniversityApiCall() async {
    try {
      var response =
          await apiClient(apiEndpoint: "get-university", context: context);
      if (response.statusCode == 200) {
        var decode = await jsonDecode(response.body);
        if (decode["code"] == 200) {
          universities.addAll(decode["data"]);
          universitiesCopy = universities;
          print(universities[0]);
          setState(() {});
        } else {
          if (!mounted) return;
          showAlert(context, "failed to get types", "error");
        }
      } else {
        if (!mounted) return;
        showAlert(context, "failed to get types", "error");
      }
    } catch (e) {
      if (!mounted) return;
      showAlert(context, "failed to get types", "error");
    }
  }

  void univerityDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setSt) {
            return Container(
              color: Colors.white,
              margin: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Material(
                      child: Container(
                          margin: const EdgeInsets.all(8),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              labelText: 'search location..',
                              hintText: 'Search Location..',
                            ),
                            // controller: locationController,
                            onChanged: (val) {
                              setState(() {
                                if (val.isEmpty) {
                                  universitiesCopy = universities;
                                } else {
                                  universitiesCopy = universities.where((data) {
                                    var stationName =
                                        data.stationName!.toLowerCase();
                                    return stationName.contains(val);
                                  }).toList();
                                }
                              });
                              setState(() {});
                            },
                          )),
                    ),
                    AnimationLimiter(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: universitiesCopy.length,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                        padding: const EdgeInsets.all(6),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        universitiesCopy[index]
                                                                ["title"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color: Color(
                                                                0xff0A1E61)),
                                                      ),
                                                      // Container(
                                                      //   margin: const EdgeInsets
                                                      //       .only(top: 2),
                                                      //   child: Text(
                                                      //     getLocationListCopy[
                                                      //             index]
                                                      //         .uniqueId
                                                      //         .toString(),
                                                      //     style: const TextStyle(
                                                      //         fontWeight:
                                                      //             FontWeight
                                                      //                 .normal,
                                                      //         fontSize: 16),
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              )),
                                        )),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }
}
