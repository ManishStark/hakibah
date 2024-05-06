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
  bool isLoading = false;
  @override
  void initState() {
    // getUniversityApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarHome(title: "Universities"),
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 26),
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.7),
                    ),
                    hintStyle: const TextStyle(fontSize: 14),
                    labelText: 'Search  University',
                    hintText: 'Search  University',
                  ),
                  // controller: locationController,
                  onChanged: (val) {
                    if (val.length < 3) {
                      showAlert(context, "please enter at least 3 characters",
                          "error");
                      universities.clear();
                      setState(() {});
                      return;
                    }
                    EasyDebounce.debounce(
                      'my-debouncer', // Provide a unique identifier for this debounce
                      const Duration(
                          milliseconds: 500), // Set the debounce duration
                      () => setState(() {
                        getUniversityApiCall(val);
                      }), // Callback function
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              if (universities.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: universities.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: secondaryColor, width: 1),
                              borderRadius: BorderRadius.circular(8.7)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context, universities[index]);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Text(universities[index]["name"])),
                          ),
                        );
                      }),
                )
            ],
          ),
        ),
        if (isLoading)
          Center(
            child: loadingSpinner(color: primaryColor),
          )
      ]),
    );
  }

  void getUniversityApiCall(String name) async {
    setState(() {
      isLoading = true;
    });
    try {
      var response = await apiClient(
          apiEndpoint: "get-university/$name", context: context);
      if (response.statusCode == 200) {
        var decode = await jsonDecode(response.body);
        if (decode["code"] == 200) {
          universities.addAll(decode["data"]);
          setState(() {});
        } else if (decode["code"] == 404) {
          if (!mounted) return;
          universities.clear();
          showAlert(context, "no universities found...", "error");
        }
      } else {
        if (!mounted) return;
        universities.clear();
        showAlert(context, "failed to get types", "error");
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      showAlert(context, "failed to get types", "error");
      setState(() {
        universities.clear();
        isLoading = false;
      });
    }
  }
}
