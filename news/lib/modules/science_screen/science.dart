import 'package:news/shared/components/components.dart';
import 'package:news/shared/news_cubit/cubit.dart';
import 'package:news/shared/news_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Science extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, States>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        var list = cubit.scienceData;
        return articleBuilder(list, context, false);
      },
    );
  }
}
