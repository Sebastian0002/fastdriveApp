part of 'bottomsheet_bloc.dart';

sealed class BottomsheetEvent extends Equatable {
  const BottomsheetEvent();

  @override
  List<Object> get props => [];
}

class OnUpdateHeightBottomSheet extends BottomsheetEvent {
  final double screenOccupiedPercentage;
  const OnUpdateHeightBottomSheet({required this.screenOccupiedPercentage});

}
