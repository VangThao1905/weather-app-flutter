import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherEventRequest extends WeatherEvent {
  final String city;

  const WeatherEventRequest({required this.city}) : assert(city != null);

  @override
  List<Object?> get props => [city];
}

class WeatherEventRefresh extends WeatherEvent {
  final String city;

  const WeatherEventRefresh({required this.city}) : assert(city != null);

  @override
  List<Object?> get props => [city];
}
