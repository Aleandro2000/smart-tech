//TO DO

import "package:flutter/material.dart";

class DataView extends StatefulWidget {
  const DataView({Key? key}) : super(key: key);

  @override
  State<DataView> createState() => _DataViewState();
}

class _DataViewState extends State<DataView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data View"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 50),
            child: const Text("TO DO!"),
          )
        ],
      ),
    );
  }
}
