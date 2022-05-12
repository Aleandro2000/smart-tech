import 'package:d_chart/d_chart.dart';
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
              child: SvgPicture.asset('assets/iot.svg'),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: DChartLine(
                    data: const [
                      {
                        'id': 'Line',
                        'data': [
                          {'domain': 0, 'measure': 2.5},
                          {'domain': 2, 'measure': 4},
                          {'domain': 3, 'measure': 6},
                          {'domain': 4, 'measure': 1},
                        ],
                      },
                    ],
                    includePoints: true,
                    lineColor: (lineData, index, id) => Colors.green,
                  ),
                ),
              ),
              elevation: 8,
              margin: const EdgeInsets.all(20),
            ),
          ],
        ),
      ],
    );
  }
}
