import 'package:flutter/material.dart';
import 'package:changefly/changefly_logo_anim.dart';
import 'package:changefly/changefly_name_anim.dart';

class SecondAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ChangeflyLogoAnim changeflyLogoAnim =
        ChangeflyLogoAnim(isBounce: true);
    final ChangeflyNameAnim changeflyNameAnim = ChangeflyNameAnim();
    return Scaffold(
      appBar: AppBar(
        title: Text('Changefly'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // refresh the screen and re-start the animations
              changeflyLogoAnim.myState.startAnimation();
              changeflyNameAnim.myState.startAnimation();
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Center(
        child: Column(
          // center the widgets in the middle of the screen
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            changeflyLogoAnim,
            SizedBox(height: 16.0),
            changeflyNameAnim,
          ],
        ),
      ),
    );
  }
}
