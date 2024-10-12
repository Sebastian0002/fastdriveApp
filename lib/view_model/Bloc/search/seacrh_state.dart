part of 'seacrh_bloc.dart';

sealed class SeacrhState extends Equatable {
  
  final bool displayManualMarker;

  const SeacrhState({
    this.displayManualMarker = false
    });

  SeacrhState copyWith ({
    bool? displayManualMarker
    }) => 
      SeacrhInitState(displayManualMarker: displayManualMarker ?? this.displayManualMarker);
  @override
  List<Object> get props => [displayManualMarker];
}

final class SeacrhInitState extends SeacrhState {
  const SeacrhInitState({super.displayManualMarker});

}
