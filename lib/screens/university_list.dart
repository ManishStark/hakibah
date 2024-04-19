import 'dart:convert';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:hakibah/components/appbar.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/utils/api_client.dart';

class UniversityListScreen extends StatefulWidget {
  const UniversityListScreen({super.key});

  @override
  State<UniversityListScreen> createState() => _UniversityListScreenState();
}

class _UniversityListScreenState extends State<UniversityListScreen> {
  var universities = [];
  var universitiesCopy = [];
  bool isLoading = false;
  @override
  void initState() {
    getUniversityApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarHome(title: "Universities"),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 26),
        margin: const EdgeInsets.only(bottom: 20),
        child: Stack(children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'Search  University',
                      hintText: 'Search  University',
                    ),
                    // controller: locationController,
                    onChanged: (val) {
                      EasyDebounce.debounce(
                        'my-debouncer', // Provide a unique identifier for this debounce
                        const Duration(
                            milliseconds: 500), // Set the debounce duration
                        () => setState(() {
                          if (val.isEmpty) {
                            universitiesCopy = universities;
                          } else {
                            universitiesCopy = universities.where((data) {
                              var stationName = data["title"]!.toLowerCase();
                              return stationName.contains(val);
                            }).toList();
                          }
                        }), // Callback function
                      );
                    },
                  ),
                ),
                if (universitiesCopy.isNotEmpty)
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return Card(
                          surfaceTintColor: whiteColor,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context, universitiesCopy[index]);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Text(universitiesCopy[index]["title"])),
                          ),
                        );
                      })
              ],
            ),
          ),
          if (isLoading)
            Center(
              child: loadingSpinner(color: primaryColor),
            )
        ]),
      ),
    );
  }

  void getUniversityApiCall() async {
    setState(() {
      isLoading = true;
    });
    try {
      var response =
          await apiClient(apiEndpoint: "get-university", context: context);
      if (response.statusCode == 200) {
        var decode = await jsonDecode(response.body);
        if (decode["code"] == 200) {
          universities.addAll(decode["data"]);
          universitiesCopy = universities;
          setState(() {});
        } else {
          if (!mounted) return;
          showAlert(context, "failed to get types", "error");
        }
      } else {
        if (!mounted) return;
        showAlert(context, "failed to get types", "error");
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      showAlert(context, "failed to get types", "error");
      setState(() {
        isLoading = false;
      });
    }
  }
}
