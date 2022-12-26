import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_cubit_weather_app/constants/constants.dart';

part 'app_theme_event.dart';
part 'app_theme_state.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, AppThemeState> {
  AppThemeBloc() : super(AppThemeState.initial()) {
    on<ToggleAppThemeEvent>((event, emit) {
      emit(state.copyWith(appThemeMode: event.appThemeMode));
    });
  }
  void setTheme(double currentTemp) {
    if (currentTemp > kWarmOrNot) {
      add(const ToggleAppThemeEvent(appThemeMode: AppThemeMode.light));
    } else {
      add(const ToggleAppThemeEvent(appThemeMode: AppThemeMode.dark));
    }
  }
}
