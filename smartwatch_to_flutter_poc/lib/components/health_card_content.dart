import 'package:flutter/material.dart';

import '../constants.dart';

class HealthCardContent extends StatelessWidget {
  const HealthCardContent(
      {super.key,
      required this.icon,
      required this.label,
      required this.value,
      required this.source});

  final IconData icon;
  final String label;
  final String value;
  final String source;

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
          label,
          style: kLabelTextStyle,
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(value, style: kValueTextStyle),
        Text(source, style: kSourceTextStyle),
      ],
    );
  }
}
