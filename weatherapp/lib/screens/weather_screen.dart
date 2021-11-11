import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/blocs/theme_bloc.dart';
import 'package:weatherapp/blocs/weather_bloc.dart';
import 'package:weatherapp/events/theme_event.dart';
import 'package:weatherapp/events/weather_event.dart';
import 'package:weatherapp/states/theme_state.dart';
import 'package:weatherapp/states/weather_state.dart';

class WeatherScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Completer<void> _completer;

  @override
  void initState() {
    super.initState();
    _completer = Completer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App using Flutter Bloc'),
        actions: [
          IconButton(
              onPressed: () {
                //Navigate Setting screen
              },
              icon: Icon(Icons.settings)),
          IconButton(
              onPressed: () async {
                //Navigate to CitySearchScreen
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, weatherState) {
            if (weatherState is WeatherStateSuccess) {
              BlocProvider.of<ThemeBloc>(context).add(ThemeEventWeatherChanged(
                  weatherCondition: weatherState.weather.weatherCondition));
              _completer?.complete();
              _completer = Completer();
            }
          },
          builder: (context, weatherState) {
            if (weatherState is WeatherStateLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (weatherState is WeatherStateSuccess) {
              final weather = weatherState.weather;
              return BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themeState) {
                return RefreshIndicator(
                  onRefresh: () {
                    BlocProvider.of<WeatherBloc>(context)
                        .add(WeatherEventRefresh(city: weather.location));
                    return _completer.future;
                  },
                  child: Container(
                    color: themeState.backgroundColor,
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            Text(
                              weather.location,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: themeState.textColor),
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                            Center(
                              child: Text(
                                  'Updated: ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
            }
            if (weatherState is WeatherStateFailure) {
              Center(
                child: Text(
                  'Something went wrong',
                  style: TextStyle(color: Colors.redAccent, fontSize: 16),
                ),
              );
            }
            return Center(
              child: Text(
                'select a location first',
                style: TextStyle(fontSize: 30),
              ),
            );
          },
        ),
      ),
    );
  }
}
