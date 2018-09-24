import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:changefly/quadratic_curve.dart';

/// Changefly Logo Animation
class ChangeflyLogoAnim extends StatefulWidget {
  bool isBounce;
  ChangeflyLogoAnim({this.isBounce = false});
  // declare the state to be able to restart the animation from the root widget
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

  // controlls the position of the cube surfaces during entry animation
  double entryPos = 0.0;
  // controlls the size of the cube surfaces during entry animation
  double entrySize = 1.0;
  // controlls the opacity of the cube surfaces during entry animation
  double opacity = 1.0;
  // controlls the size of the cube during bob animation after entry
  double bobSize = 1.0;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    entryAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        // setting the first animation to take 85% of the whole animation time
        curve: Interval(0.0, 0.85,
            curve: widget.isBounce ? Curves.bounceOut : Curves.linear),
      ),
    );

    // bobAnimation takes custom curve to animate
    bobAnimation = CurveTween(curve: QuadraticCurve()).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.9, 1.0),
      ),
    );

    controller.addListener(() {
      // the widget is rebuilt whenever setState is called.
      setState(() {
        // control the animation
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
    // centers the widget
    return Center(
      // stack the widgets on top of each other
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Transform moves the widget in x,y,z axes.
          // It also can be used to rotate or scale widgets.
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
    // reset the animation whenever the refersh button in the main screen is pressed
    controller.reset();
    // start the animation only for one time.
    await controller.animateTo(1.0);
  }
}
