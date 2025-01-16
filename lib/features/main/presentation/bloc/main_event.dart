part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}

class GetDataEvent extends MainEvent {
  final double latitude;
  final double longitude;

  const GetDataEvent({
    required this.latitude,
    required this.longitude,
  });
 

  @override
  List<Object?> get props => [ latitude, longitude];
}
