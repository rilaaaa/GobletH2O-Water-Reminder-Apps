import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:water_reminder_app/providers/water_provider.dart';
import 'package:water_reminder_app/services/notification_service.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _targetController = TextEditingController();
  final NotificationService _notificationService = NotificationService();
  late TimeOfDay _selectedTime;
  late WaterProvider waterProvider;

  @override
  void initState() {
    super.initState();
    _selectedTime = TimeOfDay.now();
    waterProvider = Provider.of<WaterProvider>(context, listen: false);
    _loadSettings();
  }

  void _loadSettings() {
    _targetController.text = waterProvider.dailyTarget.toString();
    _selectedTime = waterProvider.notificationTime ?? TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Set Reminder Time'),
              subtitle: Text(_selectedTime.format(context)),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: _selectTime,
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),
            Center(
              // Center widget added here
              child: ElevatedButton.icon(
                onPressed: () {
                  _scheduleDailyReminder();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.save),
                label: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _scheduleDailyReminder() {
    waterProvider.setNotificationTime(_selectedTime);

    final time = Time(_selectedTime.hour, _selectedTime.minute, 0);
    _notificationService.scheduleDailyNotification(
      'Drink Water',
      'It\'s time to drink water!',
      time,
    );
  }
}
