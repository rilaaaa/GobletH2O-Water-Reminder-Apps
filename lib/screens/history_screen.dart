import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_reminder_app/providers/water_provider.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final waterProvider = Provider.of<WaterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Water Intake History',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: waterProvider.waterIntakes.length,
                itemBuilder: (context, index) {
                  final intake = waterProvider.waterIntakes[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${intake.amount} ml',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${intake.time}',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
