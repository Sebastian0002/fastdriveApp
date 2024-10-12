part of 'seacrh_bloc.dart';

sealed class SeacrhEvent extends Equatable {
  const SeacrhEvent();

  @override
  List<Object> get props => [];
}

class OnManualMarketEvent extends SeacrhEvent {
  final bool isMarket;
  const OnManualMarketEvent({required this.isMarket});
}
