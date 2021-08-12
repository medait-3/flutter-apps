import 'package:bloc/bloc.dart';
import 'package:news/shared/main_cubit/states.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<States> {
  MainCubit() : super(MainInitialState());

  static MainCubit get(context) => BlocProvider.of(context);

  bool? isDark = CacheHelper.getData(key: 'isDark');

  void changeMode() {
    if (isDark == null) {
      isDark = false;
    }
    isDark = !isDark!;
    CacheHelper.putData(key: 'isDark', value: isDark!).then((value) {
      if (isDark!) {
        emit(DarkModeState());
      } else {
        emit(LightModeState());
      }
    });
  }
}
