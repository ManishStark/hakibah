import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hakibah/components/appbar.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/provider/user_provider.dart';
import 'package:hakibah/screens/university_list.dart';
import 'package:hakibah/utils/api_client.dart';
import 'package:mime/mime.dart';
import 'package:page_route_animator/page_route_animator.dart';
import "package:http/http.dart" as http;

class AddDocument extends ConsumerStatefulWidget {
  const AddDocument({super.key});

  @override
  ConsumerState<AddDocument> createState() => _AddDocumentState();
}

class _AddDocumentState extends ConsumerState<AddDocument> {
  List<dynamic> categories = [
    {"title": "- Select Category -"}
  ];
  String categoryValue = "- Select Category -";
  List<dynamic> types = [
    {"title": "- Select Type -"}
  ];
  var setCategory = {};
  var setType = {};
  String typeValue = "- Select Type -";
  dynamic university = {"title": "- Select University -"};
  String title = "";
  File? _image;
  String? _file;
  String base64Image = "";
  dynamic user = {};
  bool isLoading = false;
  @override
  void initState() {
    getCategoryApiCall();
    getTypeApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = ref.watch(userProvider);
    return Scaffold(
      appBar: const AppbarHome(title: "Add Document"),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 26, right: 26, bottom: 0),
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
                              onTap: () {
                                setCategory = category;
                                setState(() {});
                              },
                              value: category['title'],
                              child: Text(
                                category['title'],
                                style: const TextStyle(fontSize: 16),
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
                          isValidator: true,
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
                              onTap: () {
                                setType = type;
                                setState(() {});
                              },
                              value: type['title'],
                              child: Text(
                                type['title'],
                                style: const TextStyle(fontSize: 16),
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
                        "University : ",
                        style: TextStyle(
                            color: blackColor, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                          onTap: () async {
                            var data = await Navigator.push(
                              context,
                              PageRouteAnimator(
                                child: const UniversityListScreen(),
                                routeAnimation: RouteAnimation.leftToRight,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.linear,
                              ),
                            );
                            print("data-->$data");
                            if (data != null) {
                              university = data;
                              setState(() {});
                            }
                          },
                          child: Text(
                            university["title"].toString(),
                            style: const TextStyle(fontSize: 16),
                          )),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Cover Image : ",
                        style: TextStyle(
                            color: blackColor, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _image != null
                          ? Image.file(
                              _image!,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            )
                          : const Text('No image selected'),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: _pickImage,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 21,
                                    color: primaryColor.withOpacity(0.25)),
                              ],
                            ),
                            child: Text(
                              "Pick Image",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: whiteColor),
                            ),
                          ),
                        ),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "File : ",
                        style: TextStyle(
                            color: blackColor, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _file != null
                          ? Text(
                              'Selected File: ${_file!.split('/').last}',
                              style: const TextStyle(fontSize: 16),
                            )
                          : const Text('No file selected'),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: _pickFile,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 21,
                                    color: primaryColor.withOpacity(0.25)),
                              ],
                            ),
                            child: Text(
                              "Pick File",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: onSaveDocFile,
                  child: Container(
                    height: 51,
                    // padding: const EdgeInsets.symmetric(
                    //     horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 21,
                            color: primaryColor.withOpacity(0.25)),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Save Document",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: whiteColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ]),
            ),
          ),
          if (isLoading)
            Center(
              child: loadingSpinner(),
            )
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

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _image = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _file = result.files.single.path!;
      });
    } else {
      // User canceled the picker
    }
  }

  // void onSaveDoc() async {
  //   if (!mounted) return;
  //   if (setCategory.isEmpty) {
  //     showAlert(context, "please select category", "error");
  //     return;
  //   }

  //   if (title.isEmpty) {
  //     showAlert(context, "please enter title", "error");
  //     return;
  //   }
  //   if (setType.isEmpty) {
  //     showAlert(context, "please select type", "error");
  //     return;
  //   }
  //   if (_image == null) {
  //     showAlert(context, "please pick image", "error");
  //     return;
  //   }
  //   if (_file == null) {
  //     showAlert(context, "please select document", "error");
  //     return;
  //   }
  //   setState(() {
  //     isLoading = true;
  //   });
  //   String? mimeType = "";
  //   if (_image != null) {
  //     List<int> imageBytes = await _image!.readAsBytes();

  //     // Determine the MIME type dynamically
  //     mimeType = lookupMimeType(_image!.path);

  //     // If mimeType is null, default to "image/jpeg"
  //     base64Image = base64Encode(imageBytes);
  //     // base64Image = "data:$mimeType;base64,$base64Image";
  //     print("imge-->>${base64Image}");
  //   }
  //   try {
  //     Map<String, dynamic> requestBody = {
  //       "category_id": setCategory["id"].toString(),
  //       "title": title,
  //       "university_id": "1",
  //       "user_id": user["id"].toString(),
  //       "image": "data:$mimeType;base64,$base64Image",
  //       "type_id": setType["id"].toString(),
  //     };

  //     var response = await apiClient(
  //         apiEndpoint: "save-study-docs",
  //         context: context,
  //         method: "POST",
  //         requestBody: requestBody);
  //     if (response.statusCode == 200) {
  //       var decode = await jsonDecode(response.body);
  //       if (decode["status"] == 200) {
  //         setState(() {
  //           showAlert(context, "document uploaded..", "success");
  //           setCategory = {};
  //           setType = {};
  //           university = {};
  //           title = "";
  //           _image = null;
  //           _file = null;
  //         });
  //       } else {
  //         showAlert(context, "failed to save document..", "error");
  //       }
  //     } else {
  //       showAlert(context, "failed to save document..", "error");
  //     }
  //     setState(() {
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //       showAlert(context, "failed to save document..", "error");
  //     });
  //   }
  // }

  void onSaveDocFile() async {
    if (!mounted) return;
    if (setCategory.isEmpty) {
      showAlert(context, "please select category", "error");
      return;
    }

    if (title.isEmpty) {
      showAlert(context, "please enter title", "error");
      return;
    }
    if (setType.isEmpty) {
      showAlert(context, "please select type", "error");
      return;
    }
    if (_image == null) {
      showAlert(context, "please pick image", "error");
      return;
    }
    if (_file == null) {
      showAlert(context, "please select document", "error");
      return;
    }
    setState(() {
      isLoading = true;
    });
    String? mimeType = "";
    if (_image != null) {
      List<int> imageBytes = await _image!.readAsBytes();
      mimeType = lookupMimeType(_image!.path);
      base64Image = base64Encode(imageBytes);
    }
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://thinkdream.in/hakibah_new/public/api/save-study-docs-with-file'),
      );

      request.fields['category_id'] = setCategory["id"].toString();
      request.fields['title'] = title;
      request.fields['university_id'] = "1";
      request.fields['user_id'] = user["id"].toString();
      request.fields['type_id'] = setType["id"].toString();
      request.fields['image'] = "data:$mimeType;base64,$base64Image";
      var imageFile = await http.MultipartFile.fromPath('file', _image!.path);
      request.files.add(imageFile);

      var response = await request.send();
      if (response.statusCode == 200) {
        setState(() {
          showAlert(context, "document uploaded..", "success");
          setCategory = {};
          setType = {};
          university = {};
          title = "";
          _image = null;
          _file = null;
        });
      } else {
        if (!mounted) return;
        showAlert(context, "failed to save document..", "error");
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        showAlert(context, "failed to save document..", "error");
      });
    }
  }
}
