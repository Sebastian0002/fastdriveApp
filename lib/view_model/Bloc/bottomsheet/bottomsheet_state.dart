part of 'bottomsheet_bloc.dart';

sealed class BottomsheetState extends Equatable {
  final double screenOccupiedPercentage;
  const BottomsheetState({
    required this.screenOccupiedPercentage
  });

  BottomsheetState copyWith ({
    double? screenOccupiedPercentage
  }) => 
    BottomsheetInitial(
      screenOccupiedPercentage: screenOccupiedPercentage ?? this.screenOccupiedPercentage
    );

  @override
  List<Object> get props => [screenOccupiedPercentage];
}

final class BottomsheetInitial extends BottomsheetState {
  const BottomsheetInitial({required super.screenOccupiedPercentage});

}
