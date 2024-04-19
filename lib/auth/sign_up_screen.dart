import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hakibah/auth/login_screen.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/utils/api_client.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool passObscure = true;
  bool rePassObscure = true;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String rePassword = "";
  String firstName = "";
  String lastName = "";
  String userName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: null,
      body: SafeArea(
        child: Stack(children: [
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
                      "Sign Up",
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
                      "Start your learning journey!",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: secondaryColor.withOpacity(0.5)),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    Text(
                      "First Name",
                      style: TextStyle(
                          fontSize: 12,
                          color: blackColor.withOpacity(0.7),
                          fontWeight: FontWeight.w400),
                    ),
                    textFormFieldApp(
                        name: "first name",
                        hintText: "Enter first name",
                        textValue: email,
                        onValueChanged: (val) {
                          firstName = val;
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Last Name",
                      style: TextStyle(
                          fontSize: 12,
                          color: blackColor.withOpacity(0.7),
                          fontWeight: FontWeight.w400),
                    ),
                    textFormFieldApp(
                        name: "last name",
                        hintText: "Enter last name",
                        textValue: email,
                        onValueChanged: (val) {
                          lastName = val;
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Username",
                      style: TextStyle(
                          fontSize: 12,
                          color: blackColor.withOpacity(0.7),
                          fontWeight: FontWeight.w400),
                    ),
                    textFormFieldApp(
                        name: "username",
                        hintText: "Enter username",
                        textValue: email,
                        onValueChanged: (val) {
                          userName = val;
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Email Address",
                      style: TextStyle(
                          fontSize: 12,
                          color: blackColor.withOpacity(0.7),
                          fontWeight: FontWeight.w400),
                    ),
                    textFormFieldApp(
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
                      height: 25,
                    ),
                    Text(
                      "RePassword",
                      style: TextStyle(
                          fontSize: 12,
                          color: blackColor.withOpacity(0.7),
                          fontWeight: FontWeight.w400),
                    ),
                    TextFormField(
                      initialValue: rePassword,
                      obscureText: rePassObscure,
                      cursorColor: primaryColor,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter re-password";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        rePassword = value!;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter your re-password",
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
                            rePassObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: secondaryColor.withOpacity(0.3),
                          ),
                          onPressed: () {
                            toggleObscureRePasswword(!rePassObscure);
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
                    Center(
                      child: GestureDetector(
                        onTap: registerApiCall,
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
                            "Sign Up",
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
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: primaryColor),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const Center(child: Text("OR")),
                    //     const SizedBox(
                    //       height: 20,
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {},
                    //       child: Text(
                    //         "View As Guest",
                    //         style: TextStyle(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w600,
                    //             color: primaryColor),
                    //       ),
                    //     )
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
          ),
          isLoading
              ? Center(child: loadingSpinner(color: primaryColor))
              : Container()
        ]),
      ),
    );
  }

  toggleObscure(bool obscure) {
    setState(() {
      passObscure = obscure;
    });
  }

  toggleObscureRePasswword(bool obscure) {
    setState(() {
      rePassObscure = obscure;
    });
  }

  void registerApiCall() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (password != rePassword) {
        showAlert(context, "password and re-password did not match..", "error");
        return;
      }

      Map<String, dynamic> requestBody = {
        "first_name": firstName,
        "last_name": lastName,
        "username": userName,
        "email": email,
        "password": password,
      };
      try {
        setState(() {
          isLoading = true;
        });
        var response = await apiClient(
            apiEndpoint: "register",
            method: "POST",
            context: context,
            requestBody: requestBody);
        if (response.statusCode == 200) {
          var decode = await jsonDecode(response.body);
          if (!mounted) return;
          if (decode["code"] == "200") {
            showAlert(context, "Signed up succesful, now login.", "success");
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
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
