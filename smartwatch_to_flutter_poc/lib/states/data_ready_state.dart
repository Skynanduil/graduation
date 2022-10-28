import 'package:flutter/material.dart';

import '../components/health_card.dart';
import '../components/health_card_content.dart';
import '../enums/health_data_types.dart';

class DataReadyState extends StatelessWidget {
  const DataReadyState(
      {super.key,
      required this.steps,
      required this.bloodOxygen,
      required this.heartrate});

  final int steps;
  final int bloodOxygen;
  final int heartrate;

  @override
  Widget build(BuildContext context) {
    print(health_data_types.heartrate.toString());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: HealthCard(
                  cardChild: HealthCardContent(
                      icon: Icons.monitor_heart,
                      label: health_data_types.heartrate,
                      value: heartrate.toString()),
                ),
              ),
              Expanded(
                child: HealthCard(
                  cardChild: HealthCardContent(
                      icon: Icons.abc,
                      label: health_data_types.steps,
                      value: steps.toString()),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: HealthCard(
            cardChild: HealthCardContent(
                icon: Icons.bloodtype,
                label: health_data_types.spO2,
                value: bloodOxygen.toString()),
          ),
        )
      ],
    );
  }
}
