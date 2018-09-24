import 'package:flutter/material.dart';

/// Changefly Name Animation
class ChangeflyNameAnim extends StatefulWidget {
  // declare the state to be able to restart the animation from the root widget
  _ChangeflyNameAnimState myState;
  @override
  _ChangeflyNameAnimState createState() {
    myState = _ChangeflyNameAnimState();
    return myState;
  }
}

class _ChangeflyNameAnimState extends State<ChangeflyNameAnim>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  // declare initial opacity to full opacity
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

    controller.addListener(() {
      setState(() {
        // set the opacity of the name to change linearly from 0.0 to 1.0
        opacity = animation.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Image.asset(
        'assets/images/changefly-name.png',
        // width of the name is half the screen
        width: MediaQuery.of(context).size.width * 0.5,
      ),
    );
  }

  void startAnimation() async {
    // reset the animation whenever the refersh button in the main screen is pressed
    controller.reset();
    // start the animation only for one time.
    await controller.animateTo(1.0, curve: Curves.fastOutSlowIn);
  }
}
