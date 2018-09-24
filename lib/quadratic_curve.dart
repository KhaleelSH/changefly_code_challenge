import 'package:flutter/material.dart';

class QuadraticCurve extends Curve {
  @override
  double transform(double t) {
    if (t == 0.0 || t == 1.0) {
      return t;
    }

    t = t - 0.5;
    double y = (-((t) * (t)) + 0.25) + 1.0;
    return y;
  }
}
