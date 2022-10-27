import 'package:flutter/material.dart';

class DataReadyState extends StatelessWidget {
  const DataReadyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('DataReadyState');
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.stretch,
    //   children: [
    //     Expanded(
    //       child: Row(
    //         children: [
    //           Expanded(
    //             child: HealthCard(
    //               cardChild: HealthCardContent(
    //                 icon: Icons.monitor_heart,
    //                 label: health_data_types.heartrate,
    //                 value: heartrate != 0.0
    //                     ? heartrate.toString()
    //                     : _contentNoData(),
    //               ),
    //             ),
    //           ),
    //           //HealthCard(color: , cardChild: cardChild, onPress: onPress), // Steps
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}
