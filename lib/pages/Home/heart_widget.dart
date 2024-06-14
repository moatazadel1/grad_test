import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HeartRateWidget extends StatefulWidget {
  const HeartRateWidget({super.key});

  @override
  State<HeartRateWidget> createState() => _HeartRateWidgetState();
}

class _HeartRateWidgetState extends State<HeartRateWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.09),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Heart Rate",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Normal: 78 BPM",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0), // Adjust as necessary
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 10,
                minY: 0,
                maxY: 5,
                gridData: const FlGridData(
                  show: false,
                ),
                lineTouchData: LineTouchData(
                  enabled: true,
                  handleBuiltInTouches: true,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) => Colors.white,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((touchedSpot) {
                        return LineTooltipItem(
                          'Happy',
                          TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: Colors.transparent, // Adjust border color as needed
                  ),
                ),
                titlesData: const FlTitlesData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 3),
                      const FlSpot(2, 3.5),
                      const FlSpot(4, 4),
                      const FlSpot(6, 2.5),
                      const FlSpot(8, 4),
                      const FlSpot(10, 3),
                    ],
                    isCurved: true,
                    // colors: [
                    //   Theme.of(context).primaryColor.withOpacity(0.2),
                    //   Theme.of(context).primaryColor,
                    // ], // Use colors instead of color
                    color: Theme.of(context).primaryColor,
                    barWidth: 6,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      // colors: [
                      //   Theme.of(context).primaryColor.withOpacity(0.1),
                      //   Theme.of(context).primaryColor.withOpacity(0.2),
                      // ], // Adjust opacity as needed
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
