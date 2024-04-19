import 'package:flutter/material.dart';
import 'package:hakibah/components/appbar.dart';

class ViewDocumentScreen extends StatefulWidget {
  const ViewDocumentScreen({super.key});

  @override
  State<ViewDocumentScreen> createState() => _ViewDocumentScreenState();
}

class _ViewDocumentScreenState extends State<ViewDocumentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarHome(title: "View Docuement"),
      body: Stack(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: [Text("title")],
              ),
            ),
          )
        ],
      ),
    );
  }
}
