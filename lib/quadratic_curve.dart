import 'package:flutter/material.dart';

class QuadraticCurve extends Curve {
  @override
  double transform(double t) {
    // required by the flutter framework
    if (t == 0.0 || t == 1.0) {
      return t;
    }

    // to center the curve in the The Cartesian Curve
    t = t - 0.5;

    // the curve starts at 1.0 and ends at 1.0
    // and returns the Quadratic curve "inverted"
    double y = (-((t) * (t)) + 0.25) + 1.0;
    return y;
  }
}
