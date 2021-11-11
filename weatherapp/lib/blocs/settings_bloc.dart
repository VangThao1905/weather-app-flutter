import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/events/settings_event.dart';
import 'package:weatherapp/states/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc()
      : super(SettingsState(temperatureUnit: TemperatureUnit.celsius));

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent settingsEvent) async* {
    if (settingsEvent is SettingEventToggleUnit) {
      yield SettingsState(
          temperatureUnit: state.temperatureUnit == TemperatureUnit.celsius ? TemperatureUnit.fahrenheit : TemperatureUnit.celsius
      );
    }
  }
}
