import 'package:flutter/material.dart';
import 'package:smartwatch_to_flutter_poc/constants.dart';

class HealthCard extends StatelessWidget {
  const HealthCard({super.key, required this.cardChild});

  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(kCardMargin),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(kCardBorderRadius),
      ),
      child: cardChild,
    );
  }
}
