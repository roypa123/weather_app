part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

class MainInitial extends MainState {}

// class MainPowerButtonState extends MainState {
//   final bool value;
//   const MainPowerButtonState({this.value = false});
// }

class FlashlightOffState extends MainState {}

class FlashlightOnState extends MainState {}

