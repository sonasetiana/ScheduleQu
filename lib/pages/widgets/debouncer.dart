import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final Duration delay;
  VoidCallback? _callback;
  Timer? _timer;

  Debouncer({required this.delay});

  void run(VoidCallback callback) {
    _callback = callback;
    _timer?.cancel();
    _timer = Timer(delay, () {
      _callback?.call();
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}
