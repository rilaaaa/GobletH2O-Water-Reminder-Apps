import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_reminder_app/providers/water_provider.dart';
import 'package:water_reminder_app/screens/home_screen.dart';
import 'package:water_reminder_app/screens/settings_screen.dart';
import 'package:water_reminder_app/screens/history_screen.dart';
import 'package:water_reminder_app/screens/tips_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WaterProvider(),
      child: MaterialApp(
        title: 'Water Reminder',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        routes: {
          '/settings': (context) => SettingsScreen(),
          '/history': (context) => HistoryScreen(),
          '/tips': (context) => TipsScreen(),
        },
      ),
    );
  }
}
