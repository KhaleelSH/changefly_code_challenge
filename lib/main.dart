import 'package:flutter/material.dart';
import 'package:changefly/changefly_logo_anim.dart';
import 'package:changefly/changefly_name_anim.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ChangeflyLogoAnim changeflyLogoAnim = ChangeflyLogoAnim();
    ChangeflyNameAnim changeflyNameAnim = ChangeflyNameAnim();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Changefly',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Changefly'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                changeflyLogoAnim.myState.startAnimation();
                changeflyNameAnim.myState.startAnimation();
              },
              tooltip: 'Refresh',
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              changeflyLogoAnim,
              SizedBox(height: 16.0),
              changeflyNameAnim,
            ],
          ),
        ),
      ),
    );
  }
}
