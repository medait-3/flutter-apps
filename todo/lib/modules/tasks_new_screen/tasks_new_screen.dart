import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/todo_cubit/todo_cubit.dart';
import 'package:todo/shared/todo_cubit/todo_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTasks extends StatefulWidget {
  @override
  _NewTasksState createState() => _NewTasksState();
}

class _NewTasksState extends State<NewTasks> {
  var screenKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (TodoCubit.get(context).newTasks.length > 0) {
          return Dismissible(
            key: screenKey,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 15,
                top: 15,
                left: 8,
                right: 8,
              ),
              child: ListView.separated(
                itemBuilder: (context, index) => showTask(
                    TodoCubit.get(context).newTasks[index],
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
                itemCount: TodoCubit.get(context).newTasks.length,
              ),
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                TodoCubit.get(context).changeIndex(1);
              } else if (direction == DismissDirection.startToEnd) {
                TodoCubit.get(context).changeIndex(2);
              }
            },
          );
        } else {
          return Dismissible(
            key: screenKey,
            child: Center(
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
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                TodoCubit.get(context).changeIndex(1);
              } else if (direction == DismissDirection.startToEnd) {
                TodoCubit.get(context).changeIndex(2);
              }
            },
          );
        }
      },
    );
  }
}
