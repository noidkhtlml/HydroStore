import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class EnergyState extends ChangeNotifier {
  double h2Kg = 4.72;
  double maxKg = 8.0;

  double solarKw = 5.1;
  double homeKw = 2.7;

  double todayH2 = 0.83;
  double monthH2 = 12.4;

  int pressure = 312;

  bool feedActive = true;

  String mode = "auto";

  Timer? _timer;

  double get tankPercentage => h2Kg / maxKg;

  double get surplusKw => max(0, solarKw - homeKw);

  void startSimulation() {
    _timer = Timer.periodic(
      const Duration(seconds: 2),
          (_) {
        solarKw = 4.5 + Random().nextDouble() * 1.2;
        homeKw = 2.3 + Random().nextDouble() * 0.8;

        final surplus = surplusKw;

        h2Kg += surplus * 0.0008;

        if (h2Kg > maxKg) {
          h2Kg = maxKg;
        }

        todayH2 += surplus * 0.0002;

        pressure = 300 + Random().nextInt(18);

        notifyListeners();
      },
    );
  }

  void toggleFeed(bool value) {
    feedActive = value;
    notifyListeners();
  }

  void setMode(String newMode) {
    mode = newMode;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}