import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/additional_info.dart';
import 'hourly_forecast_item.dart';
import 'package:http/http.dart' as http;
import 'secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'Delhi';
      final res = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?q=$cityName,india&APPID=$openWeatherAPIKey'));
      final forecastData = jsonDecode(res.body);
      if (forecastData['cod'] != '200') {
        throw 'An unexpected error occurred';
      } else {
        return forecastData;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Weather App',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                
              });
            },
            icon: const Icon(Icons.refresh_rounded),
          )
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError == true) {
            return Text(snapshot.error.toString());
          }

          final forecastData = snapshot.data!;
          double currentTemp = forecastData['list'][0]['main']['temp']-273.15;
          String currentWeather = forecastData['list'][0]['weather'][0]['main'];
          num currentHumidity = forecastData['list'][0]['main']['humidity'];
          num currentPressure = forecastData['list'][0]['main']['pressure'];
          num currentWindSpeed = forecastData['list'][0]['wind']['speed'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
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
                          children: [
                            Text(
                              '${currentTemp.toStringAsFixed(1)}°C',
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 0),
                            // icon
                            Icon(
                              currentWeather == "Clouds" ||
                                      currentWeather == "Rain "
                                  ? Icons.cloud
                                  : Icons.sunny,
                              size: 78,
                            ),
                            Text(
                              currentWeather,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Hourly Forecast',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 39,
                    itemBuilder: (context, index) {
                      final time = DateTime.parse(forecastData['list'][index+1]['dt_txt']);
                      final weather = 
                          forecastData['list'][index+1]['weather'][0]['main'];
                      return HourlyForecastItem(
                        timeinterval: DateFormat.j().format(time),
                        icon: weather == 'Clouds' ||
                                weather == 'Rain' && weather != 'Clear'
                            ? Icons.cloud
                            : Icons.sunny,
                        temperature: forecastData['list'][index+1]['main']['temp'],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
                //additional info
                const Text(
                  'Additional Info',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AdditionalInfoItem(
                      icon: Icons.water_drop_rounded,
                      label: 'Humidity',
                      value: currentHumidity.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.air_rounded,
                      label: 'Wind Speed',
                      value: currentWindSpeed.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      value: currentPressure.toString(),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
