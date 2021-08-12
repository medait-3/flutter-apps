import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/layout/shop_layout_screen.dart';
import 'package:shop/modules/login_screen/login_screen.dart';
import 'package:shop/shared/bloc_observer.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

import 'modules/on_boarding_screen/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.dioInit();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.importData(key: 'onBoarding');
  token = CacheHelper.importData(key: 'token') != null ?CacheHelper.importData(key: 'token') :null;

  late Widget startWidget= OnBoardingScreen();
  if (onBoarding != null) {
    if (token != null) {
      startWidget = ShopLayoutScreen();
    } else {
      startWidget = LoginScreen();
    }
  } else {
    OnBoardingScreen();
  }

  runApp(MyApp(startWidget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
        primarySwatch: Colors.indigo,
      ),
      themeMode: ThemeMode.light,
      home: startWidget,
    );
  }
}
