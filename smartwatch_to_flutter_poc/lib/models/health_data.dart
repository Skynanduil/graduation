import 'package:health/health.dart';

class HealthData{
  HealthData({required this.type, required this.value, required this.source});
  final HealthDataType type;
  final HealthValue value;
  final String source;
}