import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude;
  late double longitude;
  @override
  void initState() {
    getLocation();

    super.initState();
  }

  void getData() async {
    String api = 'caeb5a7996f0aced8aa93d6029ec2a98';
    http.Response res = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$api&units=metric'));

    if (res.statusCode == 200) {
      String data = res.body;
      var decodedData = jsonDecode(data);
      double temp = decodedData['main']['temp'];
      String cityName = decodedData['name'];
      int condition = decodedData['weather'][0]['id'];

      print(temp);
      print(cityName);
      print(condition);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LocationScreen(
                locationData: decodedData,
              )));
    } else {
      print(res.statusCode);
    }
  }

  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    print(position);
    latitude = position.latitude;
    longitude = position.longitude;
    getData();
  }

  

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.blue,
          size: 100,
        ),
      ),
    );
  }
}
