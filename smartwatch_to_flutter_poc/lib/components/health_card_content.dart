import 'package:flutter/material.dart';

import '../constants.dart';
import '../enums/health_data_types.dart';

class HealthCardContent extends StatelessWidget {
  const HealthCardContent(
      {super.key,
      required this.icon,
      required this.label,
      required this.value});

  final IconData icon;
  final health_data_types label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: kIconSize,
          color: kIconColor,
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
          label.name,
          style: kLabelTextStyle,
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(value, style: kValueTextStyle),
      ],
    );
  }
}
