import 'package:equatable/equatable.dart';
import 'package:weatherapp/models/Weather.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeEventWeatherChanged extends ThemeEvent {
  final WeatherCondition weatherCondition;

  ThemeEventWeatherChanged({required this.weatherCondition})
      : assert(weatherCondition != null);

  @override
  List<Object?> get props => [];
}
