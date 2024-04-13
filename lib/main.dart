import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(const ProviderScope(child: Hakibah())));
}

class Hakibah extends StatelessWidget {
  const Hakibah({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
        fontFamily: "Poppins",
        primaryColor: primaryColor,
        scaffoldBackgroundColor: whiteColor,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
