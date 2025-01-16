import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(FlashlightOffState()) {
    on<GetDataEvent>(_getDataEvent);
  }

  Future<void> _getDataEvent(
      GetDataEvent event, Emitter<MainState> emit) async {}
}
