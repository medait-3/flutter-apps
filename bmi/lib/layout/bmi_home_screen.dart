import 'dart:math';
import 'package:bmi/modules/bmi_result_screen/bmi_result_screen.dart';
import 'package:bmi/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class BmiHome extends StatefulWidget {
  @override
  _BmiHomeState createState() => _BmiHomeState();
}

class _BmiHomeState extends State<BmiHome> {
  bool isMale = true;
  double sliderValue = 170.0;
  int weight = 70;
  int age = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[700],
      appBar: AppBar(
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.indigo[700],
            statusBarIconBrightness: Brightness.light),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo[700],
        title: Text(
          'BMI CALCULATOR',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        isMale = true;
                        setState(() {});
                        print('male pressed');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isMale ? Colors.pink : Colors.indigo[900],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: Image(
                                image: AssetImage('assets/images/man.png'),
                                height: 60,
                                width: 60,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Male',
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        isMale = false;
                        setState(() {});
                        print('female pressed');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isMale ? Colors.indigo[900] : Colors.pink,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/images/woman.png'),
                              height: 60,
                              width: 60,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Female',
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.indigo[900],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Height',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white60,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${sliderValue.round()}',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              'CM',
                              style: TextStyle(
                                fontSize: 7,
                                color: Colors.white,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Slider(
                        activeColor: Colors.pink,
                        max: 250,
                        min: 50,
                        onChanged: (value) {
                          sliderValue = value;
                          setState(() {});
                        },
                        value: sliderValue),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.indigo[900],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Weight',
                            style: TextStyle(
                              fontSize: 15,
                              //fontWeight: FontWeight.bold,
                              color: Colors.white60,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '$weight',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                onPressed: () {
                                  setState(() {});
                                  weight++;
                                },
                                mini: true,
                                backgroundColor: Colors.indigo[700],
                                child: Icon(
                                  Icons.add,
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  if (weight != 1) {
                                    weight--;
                                  }

                                  setState(() {});
                                },
                                mini: true,
                                backgroundColor: Colors.indigo[700],
                                child: Icon(
                                  Icons.remove,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.indigo[900],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Age',
                            style: TextStyle(
                              fontSize: 15,
                              //fontWeight: FontWeight.bold,
                              color: Colors.white60,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '$age',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                onPressed: () {
                                  setState(() {
                                    age++;
                                  });
                                },
                                mini: true,
                                backgroundColor: Colors.indigo[700],
                                child: Icon(
                                  Icons.add,
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  setState(() {
                                    if (age != 1) {
                                      age--;
                                    }
                                  });
                                },
                                mini: true,
                                backgroundColor: Colors.indigo[700],
                                child: Icon(
                                  Icons.remove,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          MaterialButton(
            minWidth: double.infinity,
            height: 55,
            color: Colors.pink,
            onPressed: () {
              navigateTo(
                  context,
                  BmiResult(
                    status: status(result()),
                    result: result(),
                  ));
            },
            child: Text(
              'CALCULATE',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  int result() {
    double result = weight / pow(sliderValue / 100, 2);
    return result.round();
  }

  String status(int result) {
    if (result < 18)
      return 'Underweight';
    else if (result >= 18 && result < 25)
      return 'Normal';
    else if (result >= 25 && result < 30)
      return 'Overweight';
    else if (result >= 30 && result < 40)
      return 'Obese |';
    else if (result >= 40)
      return 'Obese ||';
    else
      return 'Obese |||';
  }
}
