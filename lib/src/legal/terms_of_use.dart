import "package:flutter/material.dart";
import "package:easy_pdf_viewer/easy_pdf_viewer.dart";
import 'package:hard_and_soft_mobile/src/templates/defaultAppBarTemplate.dart';

class Terms extends StatefulWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  bool _loading = true;
  late PDFDocument _doc;

  void _loadFile() async {
    _doc = await PDFDocument.fromAsset('assets/terms-of-use.pdf');

    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBarTemplate(title: "Terms of Use"),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : PDFViewer(
              document: _doc,
            ),
    );
  }
}
