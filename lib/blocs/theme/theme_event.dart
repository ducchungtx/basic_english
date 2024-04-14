import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ChangeTheme extends ThemeEvent {
  final bool useDeviceTheme;
  final bool isDark;

  const ChangeTheme({required this.isDark, required this.useDeviceTheme});

  @override
  List<Object> get props => [isDark, useDeviceTheme];
}
