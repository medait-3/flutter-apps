abstract class TodoStates {}

class InitialState extends TodoStates {}

class ChangeNavBarState extends TodoStates {
  final int index;

  ChangeNavBarState(this.index);
}

class ChangeBottomSheetState extends TodoStates {}

class ChangeFloatingButtonState extends TodoStates {}

class CreateDataBaseState extends TodoStates {}

class InsertToDataBaseState extends TodoStates {}

class GetFromDataBaseState extends TodoStates {}

class LoadingDataBaseState extends TodoStates {}

class UpdateDataBaseState extends TodoStates {}

class DeleteDataFromBaseState extends TodoStates {}
