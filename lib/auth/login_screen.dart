import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hakibah/auth/sign_up_screen.dart';
import 'package:hakibah/components/bottom_navigation.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/provider/user_provider.dart';
import 'package:hakibah/screens/select_category_screen.dart';
import 'package:hakibah/utils/api_client.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool passObscure = true;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "manish02@gmail.com";
  String password = "12345678";
  bool isInternet = true;
  @override
  void initState() {
    checkConnectivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: null,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Log in",
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w500,
                            color: blackColor),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Welcome back! Glad to see you, Again!",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: secondaryColor.withOpacity(0.5)),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      Text(
                        "Email Address",
                        style: TextStyle(
                            fontSize: 12,
                            color: blackColor.withOpacity(0.7),
                            fontWeight: FontWeight.w400),
                      ),
                      textFormFieldApp(
                          context: context,
                          name: "Email Address",
                          hintText: "Youraddress@email.com",
                          textValue: email,
                          onValueChanged: (val) {
                            email = val;
                          }),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 12,
                            color: blackColor.withOpacity(0.7),
                            fontWeight: FontWeight.w400),
                      ),
                      TextFormField(
                        initialValue: password,
                        obscureText: passObscure,
                        cursorColor: primaryColor,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter password";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          password = value!;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          hintStyle: TextStyle(
                              color: secondaryColor.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.w300),
                          disabledBorder: inputBorder,
                          enabledBorder: inputBorder,
                          border: inputBorder,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: secondaryColor),
                          ),
                          errorStyle: const TextStyle(color: Colors.red),
                          suffixIcon: IconButton(
                            icon: Icon(
                              passObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: secondaryColor.withOpacity(0.3),
                            ),
                            onPressed: () {
                              toggleObscure(!passObscure);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(color: primaryColor, fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: loginApiCall,
                        child: Center(
                          child: Container(
                            height: 56,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 21,
                                    color: primaryColor.withOpacity(0.25)),
                              ],
                            ),
                            width: 247,
                            child: Text(
                              "Login",
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
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen()));
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: primaryColor),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            isLoading
                ? Center(child: loadingSpinner(color: primaryColor))
                : Container()
          ],
        ),
      ),
    );
  }

  toggleObscure(bool obscure) {
    setState(() {
      passObscure = obscure;
    });
  }

  void checkInternet() async {
    isInternet = await checkConnectivity();
    setState(() {});
  }

  void loginApiCall() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Map<String, dynamic> requestBody = {
        "email": email,
        "password": password,
      };
      try {
        setState(() {
          isLoading = true;
        });
        var response = await apiClient(
            apiEndpoint: "login",
            method: "POST",
            context: context,
            requestBody: requestBody);
        if (response.statusCode == 200) {
          var decode = await jsonDecode(response.body);
          if (!mounted) return;
          if (decode["code"] == "200") {
            setToken(decode["data"]["token"]);
            ref.read(userProvider.notifier).setUser(decode["data"]["user"]);
            if (!mounted) return;
            showAlert(context, "login succesful", "success");
            String isInterestCategory = await getInterestCategory();
            if (!mounted) return;
            if (isInterestCategory.isEmpty) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SelectCategoryScreen()));
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PresistantNavbar()));
            }
          } else if (decode["code"] == "403") {
            showAlert(context, "email or password is invalid.", "error");
          } else {
            showAlert(context, apiErrorString, "error");
          }
        } else {
          if (!mounted) return;
          showAlert(context, apiErrorString, "error");
        }
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        if (!context.mounted) return;
        showAlert(context, apiErrorString, "error");
      }
    }
  }
}
