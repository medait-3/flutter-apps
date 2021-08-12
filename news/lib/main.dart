import 'package:bloc/bloc.dart';
import 'package:news/layout/news%20layout/news_layout.dart';
import 'package:news/modules/business_screen/business.dart';
import 'package:news/shared/bloc_observer.dart';
import 'package:news/shared/main_cubit/cubit.dart';
import 'package:news/shared/main_cubit/states.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';
import 'package:news/shared/news_cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  // Ensure that initialization executed before running MyApp
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.dioInit();
  await CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => NewsCubit()
            ..getBusinessData()
            ..getSportsData()
            ..getScienceData(),
        ),
        BlocProvider(create: (BuildContext context) => MainCubit()),
      ],
      child: BlocConsumer<MainCubit, States>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            darkTheme: ThemeData(
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
              )),
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.white70,
                ),
                color: Colors.black,
                titleSpacing: 15,
                titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                  statusBarIconBrightness: Brightness.light,
                ),
                elevation: 0,
              ),
              scaffoldBackgroundColor: Colors.black,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  elevation: 0.0,
                  backgroundColor: Colors.black,
                  selectedItemColor: Colors.orange,
                  unselectedItemColor: Colors.white70),
            ),
            theme: ThemeData(
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              )),
              appBarTheme: AppBarTheme(
                titleSpacing: 15,
                iconTheme: IconThemeData(
                  color: Colors.black54,
                ),
                color: Colors.white,
                titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                elevation: 0,
              ),
              scaffoldBackgroundColor: Colors.white,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                elevation: 0.0,
                backgroundColor: Colors.white,
                selectedItemColor: Colors.orange,
              ),
            ),
            themeMode: whichTheme(MainCubit.get(context).isDark),
            debugShowCheckedModeBanner: false,
            home: NewsHome(),
          );
        },
      ),
    );
  }

  ThemeMode whichTheme(bool? isDark) {
    if (isDark == null || isDark == false) {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }
}
