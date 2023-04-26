import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/services/weather.dart';


class LocationScreen extends StatefulWidget {
  final locationData;
  const LocationScreen({super.key, this.locationData});

  @override
  // ignore: library_private_types_in_public_api
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late double temp;
  late String cityName;
  late int condition;
  late int temperature;
  late String weather;
  late String msg;
  @override
  void initState() {
    updateUi(widget.locationData);
    super.initState();
  }

  void updateUi(weatherData) {
    temp = weatherData['main']['temp'];
    temperature = temp.toInt();
    cityName = weatherData['name'];
    condition = weatherData['weather'][0]['id'];
    weather = WeatherModel.getWeatherIcon(condition);
    msg = WeatherModel.getMessage(temperature);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.near_me,
                        size: 50,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.location_city,
                        size: 50,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    '$temperature°',
                    style: GoogleFonts.poppins(fontSize: 100),
                  ),
                  Text(
                    weather,
                    style: const TextStyle(fontSize: 100),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Text(
                "$msg in $cityName!",
                textAlign: TextAlign.right,
                style: GoogleFonts.poppins(fontSize: 60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
