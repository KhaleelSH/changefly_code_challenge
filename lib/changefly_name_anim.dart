import 'package:flutter/material.dart';

class ChangeflyNameAnim extends StatefulWidget {
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

  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

    controller.addListener(() {
      setState(() {
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
        width: MediaQuery.of(context).size.width * 0.5,
      ),
    );
  }

  void startAnimation() async {
    controller.reset();
    await controller.animateTo(1.0, curve: Curves.fastOutSlowIn);
  }
}
