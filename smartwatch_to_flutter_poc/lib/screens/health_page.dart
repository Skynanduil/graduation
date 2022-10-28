import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

import '../enums/app_state.dart';
import '../states/data_not_fetched.dart';
import '../states/data_ready_state.dart';
import '../states/fetching_data_state.dart';
import '../states/no_data_state.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  @override
  _HealthPageState createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  final String appBarTitle = 'Health';

  List<HealthDataPoint> _healthDataList = [];
  AppState _state = AppState.DATA_READY;

  int getSteps() => 20;

  final _stateManager = <AppState, Widget>{
    AppState.DATA_NOT_FETCHED: const DataNotFetchedState(),
    AppState.FETCHING_DATA: const FetchingDataState(),
    AppState.NO_DATA: const NoDataState(),
  };

  HealthFactory health = HealthFactory();

  Future fetchData() async {
    setState(() {
      _state = AppState.FETCHING_DATA;
    });
    final types = [
      HealthDataType.STEPS,
      HealthDataType.BLOOD_OXYGEN,
      HealthDataType.HEART_RATE,
    ];

    final permissions = [
      HealthDataAccess.READ,
      HealthDataAccess.READ,
      HealthDataAccess.READ,
    ];

    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    bool requested =
        await health.requestAuthorization(types, permissions: permissions);
    print('requested: $requested');

    await Permission.activityRecognition.request();

    if (requested) {
      try {
        List<HealthDataPoint> healthData =
            await health.getHealthDataFromTypes(yesterday, now, types);
        _healthDataList.addAll(
            healthData.length < 100 ? healthData : healthData.sublist(0, 100));
      } catch (error) {
        print("Exception in getHealthDataFromTypes: $error");
      }

      _healthDataList = HealthFactory.removeDuplicates(_healthDataList);
      for (var x in _healthDataList) {
        print(x);
      }

      setState(() {
        if (_healthDataList.isNotEmpty) {
          _stateManager[AppState.DATA_READY] = DataReadyState(
            steps: getSteps(), //TODO: Get actual steps
            heartrate: 20, //TODO: Get actual heartrate
            bloodOxygen: 20, //TODO: Get actual spo2
          );
          _state = AppState.DATA_READY;
        } else {
          _state = AppState.NO_DATA;
        }
      });
    } else {
      print("Authorization not granted");
      setState(() {
        _state = AppState.DATA_NOT_FETCHED;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          actions: [
            IconButton(
                onPressed: () {
                  fetchData();
                },
                icon: const Icon(Icons.file_download)),
          ],
        ),
        body: _stateManager[_state]);
  }
}
