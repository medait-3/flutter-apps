import 'package:flutter/material.dart';

class SecoundPage1 extends StatelessWidget {
  const SecoundPage1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('sceen1'),
        ),
      ),
      body: Material(
        child: Column(
          children: <Widget>[
            Text(
              'screen1',
            ),
            GestureDetector(
              child: Text('click me'),
              onTap: () {
                Navigator.of(context).pushNamed('/screen2');
              },
            )
          ],
        ),
      ),
    );
  }
}
