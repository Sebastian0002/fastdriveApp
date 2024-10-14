import 'dart:async';
import 'package:flutter/foundation.dart';


class Debouncer {
  final Duration duration;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.duration});

  run(VoidCallback action) {
    if (_timer?.isActive ?? false) _timer!.cancel();
    _timer = Timer(duration, action);
  }
}