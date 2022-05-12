//TO DO

import "package:flutter/material.dart";
import 'package:hard_and_soft_mobile/src/templates/defaultAppBarTemplate.dart';

class DataView extends StatefulWidget {
  const DataView({Key? key}) : super(key: key);

  @override
  State<DataView> createState() => _DataViewState();
}

class _DataViewState extends State<DataView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBarTemplate(
        title: "Data View",
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 12.5),
            child: const Text("TO DO!"),
          )
        ],
      ),
    );
  }
}
