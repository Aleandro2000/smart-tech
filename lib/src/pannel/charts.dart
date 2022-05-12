//To DO

import "package:flutter/material.dart";
import 'package:d_chart/d_chart.dart';
import 'package:hard_and_soft_mobile/src/templates/defaultAppBarTemplate.dart';

class Charts extends StatefulWidget {
  const Charts({Key? key}) : super(key: key);

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBarTemplate(
        title: "Charts",
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const RotatedBox(quarterTurns: 3, child: Text('Done tasks')),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: DChartLine(
                          lineColor: (lineData, index, id) {
                            return id == 'Line 1' ? Colors.blue : Colors.amber;
                          },
                          data: const [
                            {
                              'id': 'Line 1',
                              'data': [
                                {'domain': 1, 'measure': 3},
                                {'domain': 2, 'measure': 3},
                                {'domain': 3, 'measure': 4},
                                {'domain': 4, 'measure': 6},
                                {'domain': 5, 'measure': 0.3},
                              ],
                            },
                            {
                              'id': 'Line 2',
                              'data': [
                                {'domain': 1, 'measure': 4},
                                {'domain': 2, 'measure': 5},
                                {'domain': 3, 'measure': 2},
                                {'domain': 4, 'measure': 1},
                                {'domain': 5, 'measure': 2.5},
                              ],
                            },
                          ],
                          includePoints: true,
                        ),
                      ),
                      Text('Day'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
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
                lineColor: (lineData, index, id) => Colors.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
