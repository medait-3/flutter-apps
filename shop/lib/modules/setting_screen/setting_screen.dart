import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/shared/components/constants.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.indigo,
            statusBarIconBrightness: Brightness.light),
        elevation: 0,
        backgroundColor: Colors.indigo,
        backwardsCompatibility: false,
        title: Text(
          'MATGAR',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
        ),
        titleSpacing: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.indigo[700],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Dark mode',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Spacer(),
                      Switch(
                        value: isDark == null || isDark == false ? false : true,
                        onChanged: (value) {
                          isDark = !isDark!;
                          print(isDark.toString());
                          setState(() {});
                        },
                        activeColor: Colors.pink,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Language',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Spacer(),
                      Switch(
                        value: isArabic == null || isArabic == false
                            ? false
                            : true,
                        onChanged: (value) {
                          isArabic = !isArabic!;
                          print(isArabic.toString());
                          setState(() {});
                        },
                        activeColor: Colors.pink,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
