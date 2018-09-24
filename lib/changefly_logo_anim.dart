import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:changefly/quadratic_curve.dart';

class ChangeflyLogoAnim extends StatefulWidget {
  _ChangeflyLogoAnimState myState;
  @override
  _ChangeflyLogoAnimState createState() {
    myState = _ChangeflyLogoAnimState();
    return myState;
  }
}

class _ChangeflyLogoAnimState extends State<ChangeflyLogoAnim>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation entryAnimation;
  Animation bobAnimation;

  double entryPos = 0.0;
  double entrySize = 1.0;
  double opacity = 1.0;
  double bobSize = 1.0;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    entryAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.85, curve: Curves.linear),
      ),
    );

    bobAnimation = CurveTween(curve: QuadraticCurve()).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.9, 1.0),
      ),
    );

    controller.addListener(() {
      setState(() {
        entryPos = (-1.0 * (MediaQuery.of(context).size.height / 2.0) + 100.0) *
            (1 - entryAnimation.value);
        entrySize = (130 - entryAnimation.value * 30) / 100.0;
        opacity = (entryAnimation.value * 80 + 20) / 100.0;
        bobSize = bobAnimation.value == 0.0 ? 1.0 : bobAnimation.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Transform(
            transform: Matrix4.compose(Vector3(0.0, entryPos, 0.0),
                Quaternion(0.0, 0.0, 0.0, 0.0), Vector3(1.0, 1.0, 1.0)),
            child: Center(
              child: Opacity(
                opacity: opacity,
                child: Image.asset(
                  'assets/images/changefly-cube-top.png',
                  width: MediaQuery.of(context).size.width *
                      0.5 *
                      entrySize *
                      bobSize,
                ),
              ),
            ),
          ),
          Transform(
            transform: Matrix4.compose(Vector3(entryPos, -entryPos, 0.0),
                Quaternion(0.0, 0.0, 0.0, 0.0), Vector3(1.0, 1.0, 1.0)),
            child: Center(
              child: Opacity(
                opacity: opacity,
                child: Image.asset(
                  'assets/images/changefly-cube-left.png',
                  width: MediaQuery.of(context).size.width *
                      0.5 *
                      entrySize *
                      bobSize,
                ),
              ),
            ),
          ),
          Transform(
            transform: Matrix4.compose(Vector3(-entryPos, -entryPos, 0.0),
                Quaternion(0.0, 0.0, 0.0, 0.0), Vector3(1.0, 1.0, 1.0)),
            child: Center(
              child: Opacity(
                opacity: opacity,
                child: Image.asset(
                  'assets/images/changefly-cube-right.png',
                  width: MediaQuery.of(context).size.width *
                      0.5 *
                      entrySize *
                      bobSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void startAnimation() async {
    controller.reset();
    await controller.animateTo(1.0);
  }
}
