import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/todo_cubit/todo_cubit.dart';
import 'package:todo/shared/todo_cubit/todo_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchivedTasks extends StatefulWidget {
  @override
  _ArchivedTasksState createState() => _ArchivedTasksState();
}

class _ArchivedTasksState extends State<ArchivedTasks> {
  var screenKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: screenKey,
      child: BlocConsumer<TodoCubit, TodoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (TodoCubit.get(context).archivedTasks.length > 0) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 15,
                top: 15,
                left: 8,
                right: 8,
              ),
              child: ListView.separated(
                itemBuilder: (context, index) => showTask(
                    TodoCubit.get(context).archivedTasks[index],
                    context,
                    TodoCubit.get(context).currentIndex),
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                  ),
                ),
                itemCount: TodoCubit.get(context).archivedTasks.length,
              ),
            );
          } else {
            return Center(
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notes,
                      color: Colors.grey,
                      size: 40,
                    ),
                    Text(
                      'No tasks yet',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          TodoCubit.get(context).changeIndex(0);
        } else if (direction == DismissDirection.startToEnd) {
          TodoCubit.get(context).changeIndex(1);
        }
      },
    );
  }
}
