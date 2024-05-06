import 'package:flutter/material.dart';
import 'package:hakibah/components/appbar.dart';

class MyDocumentsScreen extends StatefulWidget {
  const MyDocumentsScreen({super.key});

  @override
  State<MyDocumentsScreen> createState() => _MyDocumentsScreenState();
}

class _MyDocumentsScreenState extends State<MyDocumentsScreen> {
  List<dynamic> myDocuments = [];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppbarHome(
        title: "My Documents",
      ),
      body: Stack(
        children: [],
      ),
    );
  }
}
