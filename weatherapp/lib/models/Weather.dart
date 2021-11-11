import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final WeatherCondition weatherCondition;
  final String formattedCondition;
  final double minTemp;
  final double temp;
  final double maxTemp;
  final int locationId;
  final String created;
  final DateTime lastUpdated;
  final String location;

  Weather(
      {required this.weatherCondition,
      required this.formattedCondition,
      required this.minTemp,
      required this.temp,
      required this.maxTemp,
      required this.locationId,
      required this.created,
      required this.lastUpdated,
      required this.location});

  @override
  List<Object?> get props => [
        weatherCondition,
        formattedCondition,
        minTemp,
        temp,
        maxTemp,
        locationId,
        created,
        lastUpdated,
        location
      ];

//Convert JSON to Weather object
  factory Weather.fromJson(dynamic jsonObject) {
    final consolidatedWeather = jsonObject['consolidated_weather'][0];
    return Weather(
        weatherCondition: _mapStringToWeatherCondition(
            consolidatedWeather['weather_state_abbr'] ?? ''),
        formattedCondition: consolidatedWeather['weather_state_name'] ?? '',
        minTemp: consolidatedWeather['min_temp'] as double,
        temp: consolidatedWeather['the_temp'] as double,
        maxTemp: consolidatedWeather['max_temp'] as double,
        locationId: jsonObject['woeid'] as int,
        //Weather On Earth Identifier => woeid
        created: consolidatedWeather['created'],
        lastUpdated: DateTime.now(),
        location: jsonObject['title']);
  }

/*
* {
consolidated_weather": [
{
"id": 6395891897335808,
"weather_state_name": "Showers",
"weather_state_abbr": "s",
"wind_direction_compass": "SSW",
"created": "2021-11-11T07:03:20.741906Z",
"applicable_date": "2021-11-11",
"min_temp": 7.845,
"max_temp": 12.815,
"the_temp": 9.1,
"wind_speed": 13.320652698830829,
"wind_direction": 205.7585937369795,
"air_pressure": 1013.0,
"humidity": 61,
"visibility": 8.863860057265569,
"predictability": 73
},
* */

  static WeatherCondition _mapStringToWeatherCondition(String inputString) {
    Map<String, WeatherCondition> map = {
      'sn': WeatherCondition.snow,
      'sl': WeatherCondition.sleet,
      'h': WeatherCondition.hail,
      't': WeatherCondition.thunderstorm,
      'hr': WeatherCondition.heavyRain,
      'lr': WeatherCondition.lightRain,
      's': WeatherCondition.showers,
      'hc': WeatherCondition.heavyCloud,
      'lc': WeatherCondition.lightCloud
    };
    return map[inputString] ?? WeatherCondition.unknow;
  }
}

enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknow
}
