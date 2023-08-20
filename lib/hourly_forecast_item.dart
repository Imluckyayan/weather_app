import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final String timeinterval;
  final IconData icon;
  final String temperature;
  const HourlyForecastItem({
    super.key,
    required this.timeinterval,
    required this.icon,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        width: 100,
        height: 115,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(timeinterval,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Icon(
              icon,
              size: 30,
            ),
            Text(temperature)
          ],
        ),
      ),
    );
  }
}
