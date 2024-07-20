import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  final List<Map<String, String>> tips = [
    {
      'title': 'Drink a glass of water first thing in the morning.',
      'icon': '🌞'
    },
    {'title': 'Carry a water bottle with you.', 'icon': '🧴'},
    {'title': 'Set reminders to drink water.', 'icon': '⏰'},
    {'title': 'Drink water before meals.', 'icon': '🍽️'},
    {'title': 'Eat more water-rich foods.', 'icon': '🥦'},
    {'title': 'Drink water when you feel thirsty.', 'icon': '😅'},
    {'title': 'Drink water after exercise.', 'icon': '🏋️‍♂️'},
    {'title': 'Keep a water bottle on your desk at work.', 'icon': '💼'},
    {'title': 'Drink herbal tea for hydration.', 'icon': '🍵'},
    {'title': 'Avoid sugary drinks; opt for water instead.', 'icon': '🥤'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Hydration Tips'),
      ),
      body: ListView.builder(
        itemCount: tips.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      tips[index]['icon'] ?? '', // Handle nullable icon value
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tips ${index + 1}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          tips[index]['title'] ??
                              '', // Handle nullable title value
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
