import 'package:flutter/material.dart';
import 'package:smartwatch_to_flutter_poc/components/health_card.dart';

class DataNotFetchedState extends StatelessWidget {
  const DataNotFetchedState({super.key});

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
                      'The data has not been fetched yet\nPlease press the button in the right-hand corner to start downloading',
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
