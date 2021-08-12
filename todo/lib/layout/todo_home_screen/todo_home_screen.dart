import 'package:flutter/services.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/todo_cubit/todo_cubit.dart';
import 'package:todo/shared/todo_cubit/todo_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TodoHome extends StatefulWidget {
  @override
  _TodoHomeState createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TodoCubit()..createDatabase(),
      child: BlocConsumer<TodoCubit, TodoStates>(
        listener: (context, state) {
          if (state is ChangeNavBarState) {
            if ((state.index == 1 || state.index == 2) &&
                TodoCubit.get(context).isBottomSheetShown == true) {
              Navigator.pop(context);
              TodoCubit.get(context).changeBottomSheetShown(false);
              TodoCubit.get(context).changeFabIcon(Icons.add);
            }
          }
        },
        builder: (context, state) {
          TodoCubit cubit = TodoCubit.get(context);
          late Widget showFloatingButtonIf;
          if (cubit.currentIndex == 0) {
            showFloatingButtonIf = FloatingActionButton(
              onPressed: () //async
                  {
                if (cubit.isBottomSheetShown == true) {
                  if (formKey.currentState!.validate()) {
                    cubit
                        .insertDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                    )
                        .then((value) {
                      Navigator.pop(context);
                      timeController.text = '';
                      titleController.text = '';
                      dateController.text = '';
                      cubit.changeBottomSheetShown(false);
                      cubit.changeFabIcon(Icons.add);
                    });
                  }
                } else {
                  cubit.changeBottomSheetShown(true);
                  cubit.changeFabIcon(Icons.check);
                  if (cubit.currentIndex == 0) {
                    scaffoldKey.currentState!
                        .showBottomSheet(
                          (context) => Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xffa5d1d9)),
                            height: 350,
                            child: Form(
                              key: formKey,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    defaultTextField(
                                      controller: titleController,
                                      type: TextInputType.text,
                                      text: 'Title',
                                      prefix: Icons.text_fields,
                                      textForUnValid:
                                          'Title should be entered !',
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    defaultTextField(
                                        controller: timeController,
                                        type: TextInputType.datetime,
                                        text: 'Time',
                                        prefix: Icons.timer,
                                        textForUnValid:
                                            'Time should be entered !',
                                        onTap: () {
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ).then((value) {
                                            timeController.text = value!
                                                .format(context)
                                                .toString();
                                          });
                                        }),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    defaultTextField(
                                      controller: dateController,
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2022),
                                        ).then((value) {
                                          dateController.text =
                                              DateFormat.yMMMd().format(value!);
                                        });
                                      },
                                      type: TextInputType.datetime,
                                      text: 'Date',
                                      prefix: Icons.date_range,
                                      textForUnValid:
                                          'Date should be entered !',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .closed
                        .then((value) {
                      cubit.changeBottomSheetShown(false);
                      cubit.changeFabIcon(Icons.add);
                    });
                  }
                }
              },
              backgroundColor: Color(0xff1E4147),
              child: Icon(cubit.fabIcon),
            );
          } else {
            showFloatingButtonIf = Container();
          }
          return Scaffold(
            backgroundColor: Colors.white,
            key: scaffoldKey,
            appBar: AppBar(
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark),
              title: Text(
                'TODO',
                style: TextStyle(
                  color: Color(0xff1E4147),
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
            ),
            body: state is! LoadingDataBaseState
                ? cubit.todoScreens[cubit.currentIndex]
                : Center(child: CircularProgressIndicator()),
            floatingActionButton: showFloatingButtonIf,
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              selectedItemColor: Color(0xff1E4147),
              backgroundColor: Colors.white,
              elevation: 0,
              unselectedItemColor: Colors.black54,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.notes,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check,
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
