part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

class MainInitial extends MainState {}

class MainSuccess extends MainState {
  const MainSuccess({this.name = "", this.humidity = "", this.windSpeed = "",this.temperature = ""});
  final String name;
  final String humidity;
  final String windSpeed;
  final String temperature;

  @override
  List<Object> get props => [name, humidity, windSpeed,temperature];
}
