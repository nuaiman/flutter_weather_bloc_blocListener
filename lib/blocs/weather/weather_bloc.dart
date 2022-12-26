import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_cubit_weather_app/repositories/weather_repository.dart';

import '../../models/custom_error.dart';
import '../../models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository})
      : super(WeatherState.initial()) {
    on<FetchWeatherEvent>(_fetchWeather);
  }
  Future<void> _fetchWeather(
      FetchWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final WeatherModel weather =
          await weatherRepository.fetchWeather(event.city);
      emit(state.copyWith(weather: weather, status: WeatherStatus.loaded));
    } on CustomError catch (e) {
      emit(state.copyWith(error: e, status: WeatherStatus.error));
    }
  }
}
