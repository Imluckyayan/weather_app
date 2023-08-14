// ignore_for_file: prefer_const_constructors
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/additional_info.dart';
import 'hourly_forecast_item.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Weather App',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh_rounded),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //main card
            SizedBox(
              width: double.infinity,
              height: 250, // take max space
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '300K',
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 0),
                        // icon
                        Icon(
                          Icons.cloud,
                          size: 78,
                        ),
                        Text(
                          'Rain',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            //forecast cars
            Text(
              'Weather Forecast',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: const Row(
                children: [
                  HourlyForecastItem(
                      icon: (Icons.cloud),
                      temperature: '200K',
                      timeinterval: '09:00'),
                  HourlyForecastItem(
                      icon: (Icons.cloud),
                      temperature: '200K',
                      timeinterval: '10:00'),
                  HourlyForecastItem(
                      icon: (Icons.sunny),
                      temperature: '300K',
                      timeinterval: '11:00'),
                  HourlyForecastItem(
                      icon: (Icons.cloud),
                      temperature: '200K',
                      timeinterval: '12:00'),
                  HourlyForecastItem(
                      icon: (Icons.sunny),
                      temperature: '300K',
                      timeinterval: '13:00'),
                ],
              ),
            ),

            SizedBox(height: 20),
            //additional info
            Text(
              'Additional Info',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                AdditionalInfoItem(
                  icon: Icons.water_drop_rounded,
                  label: 'Humidity',
                  value: '91',
                ),
                AdditionalInfoItem(
                  icon: Icons.air_rounded,
                  label: 'Wind Speed',
                  value: '1006',
                ),
                AdditionalInfoItem(
                  icon: Icons.beach_access,
                  label: 'Pressure',
                  value: '192',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
