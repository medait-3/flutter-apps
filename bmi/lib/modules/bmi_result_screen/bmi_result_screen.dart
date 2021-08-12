import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BmiResult extends StatelessWidget {
  final int result;
  final String status;

  BmiResult({
    required this.result,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[700],
      appBar: AppBar(
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.indigo[700],
            statusBarIconBrightness: Brightness.light),
        title: Text(
          'RESULT',
        ),
        elevation: 0,
        backgroundColor: Colors.indigo[700],
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              '$result',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 80,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '$status',
              style: TextStyle(
                //fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
