import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12.5),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/iot.svg',
                semanticsLabel: "Robot Arm Image",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
