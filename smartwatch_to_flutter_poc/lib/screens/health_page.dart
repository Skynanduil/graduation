import 'dart:math';

import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

import '../enums/app_state.dart';
import '../models/health_data.dart';
import '../states/data_not_fetched.dart';
import '../states/data_ready_state.dart';
import '../states/fetching_data_state.dart';
import '../states/no_data_state.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  final String appBarTitle = 'Health';

  List<HealthDataPoint> _healthDataList = [];
  AppState _state = AppState.DATA_READY;

  final _stateManager = <AppState, Widget>{
    AppState.DATA_NOT_FETCHED: const DataNotFetchedState(),
    AppState.FETCHING_DATA: const FetchingDataState(),
    AppState.NO_DATA: const NoDataState(),
  };

  HealthFactory health = HealthFactory();

  Future fetchData() async {
    _healthDataList.clear();
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
    final midnightYesterday = DateTime(now.year, now.month, now.day)
        .subtract(const Duration(days: 1));

    bool requested =
        await health.requestAuthorization(types, permissions: permissions);

    await Permission.activityRecognition.request();

    if (requested) {
      try {
        List<HealthDataPoint> healthData =
            await health.getHealthDataFromTypes(midnightYesterday, now, types);
        _healthDataList.addAll(
            healthData.length < 100 ? healthData : healthData.sublist(0, 100));
      } catch (error) {
        print(error);
      }

      _healthDataList = HealthFactory.removeDuplicates(_healthDataList);

      setState(() {
        if (_healthDataList.isNotEmpty) {
          _stateManager[AppState.DATA_READY] = DataReadyState(
            stepData: getHealthDataByType(HealthDataType.STEPS),
            heartrateData: getHealthDataByType(HealthDataType.HEART_RATE),
            bloodOxygenData: getHealthDataByType(HealthDataType.BLOOD_OXYGEN),
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

  List<HealthData> getHealthDataByType(HealthDataType type) {
    var healthDataList =
        _healthDataList.where((element) => element.type == type).toList();
    List<HealthData> filteredHealthDataList = [];
    for (var element in healthDataList) {
      filteredHealthDataList.add(
        HealthData(
          type: element.type,
          value: element.value,
          source: element.sourceName,
        ),
      );
    }
    return filteredHealthDataList;
  }

  Future addDataToHealth() async {
    final now = DateTime.now();
    final earlier = now.subtract(const Duration(minutes: 20));

    final types = [HealthDataType.STEPS];
    final rights = [HealthDataAccess.WRITE];
    final permissions = [HealthDataAccess.READ_WRITE];

    late bool perm;
    bool? hasPermission =
        await HealthFactory.hasPermissions(types, permissions: rights);
    if (hasPermission == false) {
      perm = await health.requestAuthorization(types, permissions: permissions);
    }

    int _noofSteps = Random().nextInt(100);
    print('amount of steps added: ' + _noofSteps.toString());
    bool success = await health.writeHealthData(
        _noofSteps.toDouble(), HealthDataType.STEPS, earlier, now);

    success
        ? fetchData()
        : const AlertDialog(
            title: Text("Something went wrong!"),
            content: Text("Could not add data to Apple Health."),
          );
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
            IconButton(
                onPressed: () {
                  addDataToHealth();
                },
                icon: const Icon(Icons.file_upload)),
          ],
        ),
        body: _stateManager[_state]);
  }
}
