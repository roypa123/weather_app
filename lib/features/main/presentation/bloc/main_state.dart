part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

class InitialState extends MainState {}

class SuccessState extends MainState {
  const SuccessState(
      {this.name = "",
      this.humidity = "",
      this.windSpeed = "",
      this.temperature = "",
      this.condition = "",
      this.main = ""
      
      });
  final String name;
  final String humidity;
  final String windSpeed;
  final String temperature;
  final String condition;
  final String main;

  @override
  List<Object> get props => [name, humidity, windSpeed, temperature, condition, main];
}

class ErrorState extends MainState {
  const ErrorState({
    this.errorMessage = "",
  });
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
