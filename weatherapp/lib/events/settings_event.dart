import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {}

class SettingEventToggleUnit extends SettingsEvent {
  @override
  List<Object?> get props => [];
}
