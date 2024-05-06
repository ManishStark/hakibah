import 'package:flutter/material.dart';
import 'package:hakibah/constatns.dart';
import 'package:hakibah/screens/view_documents.dart';
import 'package:hakibah/utils/reusable.dart';

class DocumentCard extends StatefulWidget {
  final dynamic document;
  const DocumentCard({required this.document, super.key});

  @override
  State<DocumentCard> createState() => _DocumentCardState();
}

class _DocumentCardState extends State<DocumentCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        goToNewScreen(
            context, ViewDocumentScreen(id: widget.document["id"].toString()));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(8.7),
            border: Border.all(color: secondaryColor, width: 1)),
        width: double.infinity,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.7),
              child: (widget.document["image"] != null)
                  ? Image.network(
                      "http://thinkdream.in/hakibah_new/public/images/${widget.document["image"]}",
                      fit: BoxFit.fill,
                      height: 100,
                      width: 100,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return errorWidget(height: 100, width: 100);
                      },
                    )
                  : errorWidget(height: 100, width: 100),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.document["title"],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              maxLines: 2,
            )
          ],
        ),
      ),
    );
  }
}
