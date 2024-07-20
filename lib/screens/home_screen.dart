import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_reminder_app/providers/water_provider.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:water_reminder_app/screens/tips_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final waterProvider = Provider.of<WaterProvider>(context);

    void updateDailyIntake() {
      if (waterProvider.totalWater < waterProvider.dailyTarget) {
        waterProvider.addWater(250);
        // Trigger UI update
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You drank 250 ml of water.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Image.asset(
              'icon.png',
              height: 30,
            ),
            SizedBox(width: 8),
            Text('Water Reminder'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
          ),
          IconButton(
            icon: Icon(Icons.lightbulb),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TipsScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total Water Drunk Today: ${waterProvider.totalWater} ml',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Daily Target: ${waterProvider.dailyTarget} ml',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              waterProvider.totalWater >= waterProvider.dailyTarget
                  ? Text(
                      'You have reached your daily goal!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    )
                  : ElevatedButton(
                      onPressed: updateDailyIntake,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.local_drink),
                          SizedBox(width: 8),
                          Text('Drink !'),
                        ],
                      ),
                    ),
              SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      LiquidCircularProgressIndicator(
                        value: waterProvider.totalWater /
                            waterProvider.dailyTarget,
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                        backgroundColor: Colors.white,
                        borderColor: Colors.blue,
                        borderWidth: 2.0,
                        direction: Axis.vertical,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'bottle.png',
                              height: 100.0,
                            ),
                            SizedBox(height: 16),
                            Text(
                              '${((waterProvider.totalWater / waterProvider.dailyTarget) * 100).toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '${waterProvider.totalWater} ml',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Daily Water Intake Progress',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  8,
                  (index) {
                    double segmentTarget = waterProvider.dailyTarget / 8;
                    bool isMet =
                        waterProvider.totalWater >= segmentTarget * (index + 1);

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isMet ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: isMet
                            ? Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              )
                            : Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
