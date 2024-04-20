import 'package:flutter/material.dart';
import 'package:hakibah/constatns.dart';

class DocumentCard extends StatefulWidget {
  final dynamic document;
  const DocumentCard({required this.document, super.key});

  @override
  State<DocumentCard> createState() => _DocumentCardState();
}

class _DocumentCardState extends State<DocumentCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          children: [
            Image.network(
              "http://thinkdream.in/hakibah_new/public/images/${widget.document["image"]}",
              fit: BoxFit.fill,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return errorWidget(height: 100, width: 100);
              },
            ),
            const SizedBox(
              height: 8,
            ),
            Text(widget.document["title"])
          ],
        ),
      ),
    );
  }
}
