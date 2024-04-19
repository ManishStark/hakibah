import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/screens/study_list_screen.dart';
import 'package:hakibah/utils/reusable.dart';

class HomeDrawer extends ConsumerStatefulWidget {
  const HomeDrawer({super.key});

  @override
  ConsumerState<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends ConsumerState<HomeDrawer> {
  bool isLoggedIn = false;
  @override
  void initState() {
    checkIfLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Drawer(
          elevation: 0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(33),
                  bottomRight: Radius.circular(33))),
          child: Container(
            color: whiteColor,
            // margin: const EdgeInsets.only(bottom: 500),
            padding: const EdgeInsets.only(top: 20, left: 26, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Visibility(
                  visible: isLoggedIn,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Image.asset(
                        "assets/images/logo.png",
                        height: 50,
                        width: 50,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      drawerData("Study List", "assets/icons/study_list.svg",
                          () async {
                        goToNewScreen(context, const StudyListScreen());
                      }),
                      drawerData("Study List", "assets/icons/study_list.svg",
                          () async {
                        goToNewScreen(context, const StudyListScreen());
                      }),
                      drawerData("Study List", "assets/icons/study_list.svg",
                          () async {
                        goToNewScreen(context, const StudyListScreen());
                      }),
                      drawerData("Study List", "assets/icons/study_list.svg",
                          () async {
                        goToNewScreen(context, const StudyListScreen());
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkIfLoggedIn() async {
    var token = await getToken();
    if (token.isNotEmpty && token != "") {
      isLoggedIn = true;
      setState(() {});
    } else {
      isLoggedIn = false;
      setState(() {});
    }
  }

  Widget drawerData(String title, String image, VoidCallback onClick) {
    return InkWell(
      onTap: () async {
        Navigator.pop(context);
        var isNetworkAvailable = await checkConnectivity();
        if (!isNetworkAvailable) {
          if (mounted) {
            showAlert(context, noInternetString, "error");
          }
          return;
        }
        onClick();
      },
      child: Container(
        padding: const EdgeInsets.only(left: 0, top: 10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    image,
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(
                    width: 13,
                    height: 13,
                  ),
                  Text(title,
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          // const Divider()
        ]),
      ),
    );
  }
}
