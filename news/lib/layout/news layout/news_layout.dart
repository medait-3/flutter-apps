import 'package:news/shared/components/components.dart';
import 'package:news/shared/main_cubit/cubit.dart';
import 'package:news/shared/news_cubit/cubit.dart';
import 'package:news/shared/news_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, States>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'morocco News',
            ),
            actions: [
              IconButton(
                onPressed: () {
                  MainCubit.get(context).changeMode();
                },
                icon: Icon(Icons.brightness_4_outlined),
              )
            ],
          ),
          body: cubit.newsScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeCurrentIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.business_outlined), label: 'Business'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sports_basketball), label: 'Sports'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.science_outlined), label: 'Science'),
            ],
          ),
        );
      },
    );
  }
}
