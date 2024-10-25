import 'package:equatable/equatable.dart';

class CardMapModel extends Equatable{
  final String urlMap;
  final String nameMap;
  final String jsonMapStyle;
  final bool isSelected;


  const CardMapModel({
    required this.nameMap,
    required this.urlMap,
    required this.jsonMapStyle,
    this.isSelected = false,
  });
  
  CardMapModel copyWith({
    bool? isSelected
  }) => 
    CardMapModel(
      nameMap: nameMap, 
      urlMap: urlMap, 
      jsonMapStyle: jsonMapStyle, 
      isSelected: isSelected ?? this.isSelected
    );


  @override
  List<Object?> get props => [urlMap, nameMap, jsonMapStyle, isSelected];
}