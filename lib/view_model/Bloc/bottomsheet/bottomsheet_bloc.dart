import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fastdrive/constants/bottomsheet.dart';

part 'bottomsheet_event.dart';
part 'bottomsheet_state.dart';

class BottomsheetBloc extends Bloc<BottomsheetEvent, BottomsheetState> {
  BottomsheetBloc() : super(const BottomsheetInitial(screenOccupiedPercentage: initialSize)) {
    on<OnUpdateHeightBottomSheet>((event, emit) {
      emit(state.copyWith(screenOccupiedPercentage: event.screenOccupiedPercentage));
    });
  }
}
