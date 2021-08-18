import 'package:flutter/material.dart';

class SecoundPage2 extends StatelessWidget {
  const SecoundPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('sceen2'),
        ),
      ),
      body: Material(
        child: Column(
          children: <Widget>[
            Text(
              'screen2',
            ),
            GestureDetector(
              child: Text('take me back'),
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
