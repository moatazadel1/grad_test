// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class HeartRateWidget extends StatelessWidget {
//   final int heartRate;
//   final String emotion;

//   const HeartRateWidget(
//       {super.key, required this.heartRate, required this.emotion});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 170,
//       width: double.maxFinite,
//       decoration: BoxDecoration(
//         color: Theme.of(context).primaryColor.withOpacity(0.09),
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Stack(
//         alignment: Alignment.topLeft,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Heart Rate",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 Text(
//                   "$emotion: $heartRate BPM",
//                   style: const TextStyle(
//                     color: Colors.grey,
//                     fontSize: 18,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 50.0), // Adjust as necessary
//             child: LineChart(
//               LineChartData(
//                 minX: 0,
//                 maxX: 10,
//                 minY: 0,
//                 maxY: 5,
//                 gridData: const FlGridData(show: false),
//                 lineTouchData: LineTouchData(
//                   enabled: true,
//                   handleBuiltInTouches: true,
//                   touchTooltipData: LineTouchTooltipData(
//                     getTooltipColor: (touchedSpot) => Colors.white,
//                     getTooltipItems: (touchedSpots) {
//                       return touchedSpots.map((touchedSpot) {
//                         return LineTooltipItem(
//                           emotion,
//                           TextStyle(
//                             color: Theme.of(context).primaryColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         );
//                       }).toList();
//                     },
//                   ),
//                 ),
//                 borderData: FlBorderData(
//                   show: true,
//                   border: Border.all(color: Colors.transparent),
//                 ),
//                 titlesData: const FlTitlesData(show: false),
//                 lineBarsData: [
//                   LineChartBarData(
//                     spots: [
//                       const FlSpot(0, 3),
//                       const FlSpot(2, 3.5),
//                       const FlSpot(4, 4),
//                       const FlSpot(6, 2.5),
//                       const FlSpot(8, 4),
//                       const FlSpot(10, 3),
//                     ],
//                     isCurved: true,
//                     color: Theme.of(context).primaryColor,
//                     barWidth: 6,
//                     dotData: const FlDotData(show: false),
//                     belowBarData: BarAreaData(
//                       show: true,
//                       color: Theme.of(context).primaryColor.withOpacity(0.2),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HeartRateWidget extends StatelessWidget {
  final int heartRate;
  final String emotion;

  const HeartRateWidget(
      {super.key, required this.heartRate, required this.emotion});

  String getEmotionForHeartRate(double heartRate) {
    if (heartRate >= 60 && heartRate <= 80) {
      return "Normal";
    }
    // } else if (heartRate >= 81 && heartRate <= 100) {
    //   return "Sad";
    else if (heartRate >= 101 && heartRate <= 120) {
      return "Happy";
    }
    //  else if (heartRate >= 121 && heartRate <= 140) {
    //   return "Angry";
    // } else if (heartRate >= 141 && heartRate <= 160) {
    //   return "Fear";
    // } else {

    return "Unknown";
  }

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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Heart Rate",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "$emotion: $heartRate BPM",
                  style: const TextStyle(
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
                minY: 60,
                maxY: 160,
                gridData: const FlGridData(show: false),
                lineTouchData: LineTouchData(
                  enabled: true,
                  handleBuiltInTouches: true,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) => Colors.white,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((touchedSpot) {
                        final hr = touchedSpot.y;
                        final emotion = getEmotionForHeartRate(hr);
                        return LineTooltipItem(
                          "$emotion: ${hr.toInt()}",
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
                  border: Border.all(color: Colors.transparent),
                ),
                titlesData: const FlTitlesData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 65),
                      // const FlSpot(2, 80),
                      const FlSpot(2, 101),
                      const FlSpot(4, 110),
                      const FlSpot(6, 120),
                      // const FlSpot(4, 110),
                      // const FlSpot(6, 130),
                      // const FlSpot(8, 150),
                      const FlSpot(10, 80),
                    ],
                    isCurved: true,
                    color: Theme.of(context).primaryColor,
                    barWidth: 6,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
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
