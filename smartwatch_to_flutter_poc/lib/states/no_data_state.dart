import 'package:flutter/material.dart';

import '../components/health_card.dart';

class NoDataState extends StatelessWidget {
  const NoDataState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 80.0,
                  child: const HealthCard(
                    cardChild: Text(
                      '\nNo Data was found',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
