import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'seacrh_event.dart';
part 'seacrh_state.dart';

class SeacrhBloc extends Bloc<SeacrhEvent, SeacrhState> {
  SeacrhBloc() : super(const SeacrhInitState()) {
    on<OnManualMarketEvent>((event, emit) {
      emit(state.copyWith(displayManualMarker: event.isMarket));
    });
  }
}
