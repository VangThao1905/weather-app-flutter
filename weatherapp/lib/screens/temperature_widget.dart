import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/blocs/settings_bloc.dart';
import 'package:weatherapp/blocs/theme_bloc.dart';
import 'package:weatherapp/models/Weather.dart';
import 'package:weatherapp/states/settings_state.dart';
import 'package:weatherapp/states/theme_state.dart';

class TemperatureWidget extends StatelessWidget {
  final Weather weather;

  TemperatureWidget({Key? key, required this.weather})
      : assert(weather != null),
        super(key: key);

  int _toFahrenheit(double celius) => ((celius * 9 / 5) + 32).round();

  String _formattedTemperature(double temp, TemperatureUnit temperatureUnit) =>
      temperatureUnit == TemperatureUnit.fahrenheit
          ? '${_toFahrenheit(temp)}°F'
          : '${_toFahrenheit(temp)}°C';

  @override
  Widget build(BuildContext context) {
    ThemeState _themeState = BlocProvider.of<ThemeBloc>(context).state;
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, settingsState) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            'Min temp:${_formattedTemperature(weather.minTemp, settingsState.temperatureUnit)}',
                            style: TextStyle(color: _themeState.textColor)),
                        Text(
                            'Temp:${_formattedTemperature(weather.temp, settingsState.temperatureUnit)}',
                            style: TextStyle(color: _themeState.textColor)),
                        Text(
                            'Max temp:${_formattedTemperature(weather.maxTemp, settingsState.temperatureUnit)}',
                            style: TextStyle(color: _themeState.textColor)),
                      ]);
                },
              ))
        ],
      )
    ]);
  }
}
