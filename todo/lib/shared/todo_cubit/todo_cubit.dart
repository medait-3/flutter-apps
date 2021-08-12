import 'package:bloc/bloc.dart';
import 'package:todo/modules/tasks_archived_screen/tasks_archived_screen.dart';
import 'package:todo/modules/tasks_done_screen/tasks_done_screen.dart';
import 'package:todo/modules/tasks_new_screen/tasks_new_screen.dart';
import 'package:todo/shared/todo_cubit/todo_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class TodoCubit extends Cubit<TodoStates> {
  TodoCubit() : super(InitialState());
  static TodoCubit get(BuildContext context) => BlocProvider.of(context);

  var currentIndex = 0;
  IconData fabIcon = Icons.add;
  bool isBottomSheetShown = false;
  List<Widget> todoScreens = [NewTasks(), DoneTasks(), ArchivedTasks()];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeNavBarState(currentIndex));
  }

  void changeFabIcon(IconData fabIcon) {
    this.fabIcon = fabIcon;
    emit(ChangeFloatingButtonState());
  }

  void changeBottomSheetShown(bool isShown) {
    isBottomSheetShown = isShown;
    emit(ChangeBottomSheetState());
  }

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  late Database database;

  Future createDatabase() async {
    await openDatabase('todo.db', version: 1,
        onCreate: (Database database, int version) async {
      print('database created');
      await database.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT , status TEXT)');
    }, onOpen: (Database database) async {
      getDatabase(database);
      print('database opened');
    }).then((value) {
      database = value;
      emit(CreateDataBaseState());
    });
  }

  Future insertDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    database.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO tasks (title, date, time, status) VALUES ("$title", "$date", "$time", "new")');
    }).then((value) {
      print('$value is inserted');
      emit(InsertToDataBaseState());
      getDatabase(database);
    });
  }

  void getDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(LoadingDataBaseState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      });
      emit(GetFromDataBaseState());
    });
  }

  void updateDatabase({
    required String status,
    required int id,
  }) async {
    await database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      emit(UpdateDataBaseState());
      getDatabase(database);
    });
  }

  void deleteDatabase({
    required int id,
  }) async {
    await database
        .rawUpdate('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      emit(DeleteDataFromBaseState());
      getDatabase(database);
    });
  }
}
