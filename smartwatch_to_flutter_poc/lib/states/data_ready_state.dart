import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:smartwatch_to_flutter_poc/models/health_data.dart';

import '../components/health_card.dart';
import '../components/health_card_content.dart';

class DataReadyState extends StatelessWidget {
  const DataReadyState({
    super.key,
    required this.stepData,
    required this.bloodOxygenData,
    required this.heartrateData,
  });

  final List<HealthData> stepData;
  final List<HealthData> bloodOxygenData;
  final List<HealthData> heartrateData;

  @override
  Widget build(BuildContext context) {
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
                    label: 'Heartrate',
                    value: (heartrateData.fold(
                              0,
                              (previousValue, element) =>
                                  previousValue +
                                  (element.value as NumericHealthValue)
                                      .numericValue
                                      .toInt(),
                            ) /
                            heartrateData.length)
                        .toString(),
                    source:
                        heartrateData.map((e) => e.source).toSet().toString(),
                  ),
                ),
              ),
              Expanded(
                child: HealthCard(
                  cardChild: HealthCardContent(
                      icon: Icons.abc,
                      label: 'Steps',
                      value: stepData
                          .fold(
                              0,
                              (previousValue, element) =>
                                  previousValue +
                                  (element.value as NumericHealthValue)
                                      .numericValue
                                      .toInt())
                          .toString(),
                      source: stepData.map((e) => e.source).toSet().toString()),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: HealthCard(
            cardChild: HealthCardContent(
              icon: Icons.bloodtype,
              label: 'Blood Oxygen',
              value: (bloodOxygenData.fold(
                        0.0,
                        (previousValue, element) =>
                            previousValue +
                            (element.value as NumericHealthValue)
                                .numericValue
                                .toDouble(),
                      ) /
                      bloodOxygenData.length)
                  .toString(),
              source: bloodOxygenData.map((e) => e.source).toSet().toString(),
            ),
          ),
        ),
      ],
    );
  }
}
