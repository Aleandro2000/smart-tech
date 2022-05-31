import "package:flutter/material.dart";
import 'package:hard_and_soft_mobile/src/pannel/bluethootView.dart';
import 'package:hard_and_soft_mobile/src/pannel/colorPicker.dart';
import 'package:hard_and_soft_mobile/src/utils/security.dart';

class PannelScreen extends StatefulWidget {
  const PannelScreen({Key? key}) : super(key: key);

  @override
  State<PannelScreen> createState() => _PannelScreenState();
}

class _PannelScreenState extends State<PannelScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Container(
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(12.5, 50, 12.5, 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                title: const Text("Bluethoot View"),
                leading: const Icon(Icons.bluetooth),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () async => {
                  if (await isRealDevice())
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BluethootView()),
                    ),
                },
              ),
            ),
            Container(
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12.5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                title: const Text("LED Color Picker"),
                leading: const Icon(Icons.palette),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () async => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ColorPickerView()),
                  ),
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
