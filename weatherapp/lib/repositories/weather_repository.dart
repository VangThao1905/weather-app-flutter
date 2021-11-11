import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/models/Weather.dart';

const baseUrl = "https://www.metaweather.com";
final locationUrl = (city) => '${baseUrl}/api/location/search/?query=${city}';
final weatherUrl = (locationId) => '${baseUrl}/api/location/${locationId}';

class WeatherRepository {
  final http.Client httpClient;

  WeatherRepository({required this.httpClient}) : assert(httpClient != null);

  Future<int> getLocationIdFromCity(String city) async {
    final response = await this.httpClient.get(Uri.parse(locationUrl(city)));
    if (response.statusCode == 200) {
      final cities = jsonDecode(response.body) as List;
      return (cities.first)['woeid'] ?? 0;
    } else {
      throw Exception('Error getting location id of:${city}');
    }
  }

  Future<Weather> fetchWeather(int locationId) async {
    final response =
        await this.httpClient.get(Uri.parse(weatherUrl(locationId)));
    if (response.statusCode != 200) {
      throw Exception('Error getting weather from locationId:${locationId}');
    }
    final weatherJson = jsonDecode(response.body);
    return Weather.fromJson(weatherJson);
  }

  Future<Weather> getWeatherFromCity(String city) async {
    final int locatonId = await getLocationIdFromCity(city);
    return fetchWeather(locatonId);
  }
}