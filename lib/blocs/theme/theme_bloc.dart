import 'package:basic_english/blocs/theme/theme_event.dart';
import 'package:basic_english/blocs/theme/theme_state.dart';
import 'package:basic_english/services/theme_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState()) {
    on<ChangeTheme>((event, emit) async {
      ThemeService.setTheme(
          useDeviceTheme: event.useDeviceTheme, isDark: event.isDark);
      emit(ThemeState(
          useDeviceTheme: event.useDeviceTheme, isDark: event.isDark));
    });
  }
}
