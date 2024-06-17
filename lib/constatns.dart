import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

String appName = "Hakibah";
Color primaryColor = const Color(0xff42c6a5);
Color secondaryColor = const Color(0xffEBF3EF);
Color whiteColor = Colors.white;
Color blackColor = Colors.black;
String noInternetString = "No Internet..";
String apiURL = "http://thinkdream.in/hakibah_new/public/api/";
String apiErrorString = "Something went wrong..please try again later..";

UnderlineInputBorder inputBorder = UnderlineInputBorder(
  borderSide: BorderSide(
      color: secondaryColor.withOpacity(0.3)), // Change color as needed
);

InputDecoration inputDecoration({required String hintText, IconData? icon}) {
  return InputDecoration(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      hintStyle: TextStyle(
          color: blackColor.withOpacity(0.6),
          fontSize: 15,
          fontWeight: FontWeight.w300),
      disabledBorder: inputBorder,
      enabledBorder: inputBorder,
      border: inputBorder,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: secondaryColor), // Change color as needed
      ),
      errorStyle: const TextStyle(color: Colors.red),
      prefixIcon: icon != null
          ? Icon(
              icon,
              color: const Color(0xff807A7A),
            )
          : null,
      prefixIconColor: const Color(0xff807A7A));
}

InputDecoration inputDecorationPassword({
  required String hintText,
  required bool obscureText,
  required Function onPressed,
}) {
  return InputDecoration(
    contentPadding:
        const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
    filled: true,
    fillColor: Colors.white,
    hintText: hintText,
    hintStyle: TextStyle(color: secondaryColor, fontSize: 14),
    disabledBorder: inputBorder,
    enabledBorder: inputBorder,
    border: inputBorder,
    focusedBorder: inputBorder,
    errorStyle: const TextStyle(color: Colors.red),
    prefixIcon: const Icon(
      Icons.lock_outline,
      color: Color(0xff807A7A),
    ),
    suffixIcon: IconButton(
      icon: Icon(
        obscureText ? Icons.visibility_off : Icons.visibility,
        color: const Color(0xff807A7A),
      ),
      onPressed: () {
        onPressed();
      },
    ),
  );
}

Widget textFormFieldApp(
    {required String name,
    IconData? icon,
    required String textValue,
    String? hintText,
    bool isValidator = true,
    required BuildContext context,
    required void Function(String) onValueChanged}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: TextFormField(
        keyboardType: TextInputType.text,
        textAlign: TextAlign.left,
        initialValue: textValue,
        onTapOutside: (e) {
          FocusScope.of(context).unfocus();
        },
        validator: isValidator
            ? (value) {
                if (value == null || value.isEmpty) {
                  return "please enter $name";
                }
                return null;
              }
            : (v) {
                return null;
              },
        style: TextStyle(
            fontSize: 15, color: blackColor, fontWeight: FontWeight.w400),
        onSaved: (value) {
          onValueChanged(
              value!); // Call the callback function with the entered value
        },
        onChanged: (value) {
          onValueChanged(value);
        },
        decoration: inputDecoration(hintText: hintText ?? name, icon: icon)),
  );
}

void showAlert(BuildContext context, String message, type) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Padding(
        padding:
            const EdgeInsets.only(bottom: 20.0), // Adjust bottom margin here
        child: Text(message),
      ),
      backgroundColor: type == "error" ? Colors.red : Colors.green.shade700,
    ),
  );
}

Widget loadingDots({Color? color, double? size}) {
  return LoadingAnimationWidget.staggeredDotsWave(
    color: color ?? primaryColor,
    size: size ?? 20,
  );
}

Widget loadingSpinner({Color? color, double? size}) {
  return LoadingAnimationWidget.threeArchedCircle(
    color: color ?? primaryColor,
    size: size ?? 40,
  );
}

Future<void> setToken(String token) async {
  var pref = await SharedPreferences.getInstance();
  pref.setString("token", token);
}

Future<void> setRefreshToken(String token) async {
  var pref = await SharedPreferences.getInstance();
  pref.setString("refresh", token);
}

Future<String> getToken() async {
  var pref = await SharedPreferences.getInstance();
  var authToken = pref.getString("token");
  if (authToken != null && authToken.isNotEmpty) {
    return authToken;
  } else {
    return "";
  }
}

Future<String> getRefreshToken() async {
  var pref = await SharedPreferences.getInstance();
  var authToken = pref.getString("refresh");
  if (authToken != null && authToken.isNotEmpty) {
    return authToken;
  } else {
    return "";
  }
}

Future<bool> checkConnectivity() async {
  return await InternetConnectionChecker().hasConnection;
}

Widget errorWidget({double? height, double? width}) {
  return Image.asset(
    "assets/images/logo.png",
    height: height ?? 50,
    width: width ?? 50,
    fit: BoxFit.contain,
  );
}

List<BoxShadow> boxShadow = [
  const BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.1),
    blurRadius: 12,
    spreadRadius: 0,
    offset: Offset(
      0,
      4,
    ),
  ),
];

Future<void> setInterestCategory(String token) async {
  var pref = await SharedPreferences.getInstance();
  pref.setString("interest_category", token);
}

Future<String> getInterestCategory() async {
  var pref = await SharedPreferences.getInstance();
  var authToken = pref.getString("interest_category");
  if (authToken != null && authToken.isNotEmpty) {
    return authToken;
  } else {
    return "";
  }
}
