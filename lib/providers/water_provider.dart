import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:water_reminder_app/models/water_intake.dart' as models;

class WaterIntake {
  final int amount;
  final DateTime time;

  WaterIntake({required this.amount, required this.time});

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'time': time.toIso8601String(),
    };
  }

  String toJson() => jsonEncode(toMap());

  static WaterIntake fromJson(String json) {
    final data = jsonDecode(json);
    return WaterIntake(
      amount: data['amount'],
      time: DateTime.parse(data['time']),
    );
  }
}

class WaterProvider with ChangeNotifier {
  List<models.WaterIntake> _waterIntakes = [];
  int _dailyTarget = 2000;
  int _totalWater = 0;
  TimeOfDay? _notificationTime;
  DateTime _lastCheckedDate = DateTime.now();

  WaterProvider() {
    _loadData();
    _loadNotificationTime();

    Timer.periodic(Duration(minutes: 1), (timer) {
      _checkDateChange();
    });
  }

  List<models.WaterIntake> get waterIntakes => _waterIntakes;
  int get dailyTarget => _dailyTarget;
  int get totalWater => _totalWater;
  TimeOfDay? get notificationTime => _notificationTime;

  void addWater(int amount) {
    final intake = models.WaterIntake(amount: amount, time: DateTime.now());
    _waterIntakes.add(intake);
    _totalWater += amount;
    notifyListeners();
    _saveData();
  }

  void setDailyTarget(int target) {
    _dailyTarget = target;
    notifyListeners();
    _saveData();
  }

  void setNotificationTime(TimeOfDay time) {
    _notificationTime = time;
    notifyListeners();
    _saveNotificationTime();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _dailyTarget = prefs.getInt('dailyTarget') ?? 2000;
    _totalWater = prefs.getInt('totalWater') ?? 0;

    final List<String>? waterIntakesString =
        prefs.getStringList('waterIntakes');
    if (waterIntakesString != null) {
      _waterIntakes = waterIntakesString
          .map((intake) => models.WaterIntake.fromJson(intake))
          .toList();
    }
    notifyListeners();
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('dailyTarget', _dailyTarget);
    prefs.setInt('totalWater', _totalWater);

    final List<String> waterIntakesString =
        _waterIntakes.map((intake) => intake.toJson()).toList();
    prefs.setStringList('waterIntakes', waterIntakesString);
  }

  Future<void> _loadNotificationTime() async {
    final prefs = await SharedPreferences.getInstance();
    final int? hour = prefs.getInt('notificationHour');
    final int? minute = prefs.getInt('notificationMinute');
    if (hour != null && minute != null) {
      _notificationTime = TimeOfDay(hour: hour, minute: minute);
    }
  }

  Future<void> _saveNotificationTime() async {
    final prefs = await SharedPreferences.getInstance();
    if (_notificationTime != null) {
      prefs.setInt('notificationHour', _notificationTime!.hour);
      prefs.setInt('notificationMinute', _notificationTime!.minute);
    }
  }

  void _checkDateChange() async {
    final now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    if (formatter.format(now) != formatter.format(_lastCheckedDate)) {
      // Reset daily water intake
      _totalWater = 0;
      _waterIntakes.clear();
      _lastCheckedDate = now;

      // Save data
      await _saveData();

      // Notify listeners of the change
      notifyListeners();
    }
  }
}
