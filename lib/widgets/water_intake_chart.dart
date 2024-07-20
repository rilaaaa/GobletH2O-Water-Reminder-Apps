import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:water_reminder_app/providers/water_provider.dart';
import 'package:water_reminder_app/models/water_intake.dart' as models;

class WaterIntakeChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final waterProvider = Provider.of<WaterProvider>(context);
    final data = [
      charts.Series<models.WaterIntake, DateTime>(
        id: 'Water Intake',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (models.WaterIntake intake, _) => intake.time,
        measureFn: (models.WaterIntake intake, _) => intake.amount,
        data: waterProvider.waterIntakes,
      )
    ];

    return charts.TimeSeriesChart(
      data,
      animate: true,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      behaviors: [
        charts.ChartTitle('Water Intake (ml)',
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
      ],
    );
  }
}
