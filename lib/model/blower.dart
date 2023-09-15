import 'package:flutter/material.dart';

class BowlerStats {
  String name;
  int runsGiven;
  int wicketsTaken;
  double economyRate;

  BowlerStats({
    required this.name,
    this.runsGiven = 0,
    this.wicketsTaken = 0,
    this.economyRate = 0.0,
  });
}

