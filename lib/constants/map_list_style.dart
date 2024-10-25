import 'dart:convert';

import 'package:fastdrive/data/models/car_map.dart';
import 'package:fastdrive/view/themes/mapThemes/themes.dart';

final List<CardMapModel> listStyleMap = [
    CardMapModel(nameMap: "Default style", urlMap: "assets/images/default.png",jsonMapStyle: jsonEncode(wyTheme) ,isSelected: true),
    CardMapModel(nameMap: "Uber style", urlMap: "assets/images/uber.png", jsonMapStyle: jsonEncode(uberTheme) ),
    CardMapModel(nameMap: "Dark style", urlMap: "assets/images/dark.png", jsonMapStyle: jsonEncode(darkTheme) ),
    CardMapModel(nameMap: "Dark blue style", urlMap: "assets/images/darkblue.png", jsonMapStyle: jsonEncode(darkBlueTheme)),
  ];