import 'dart:async';

import 'package:bai_tap_1/model/todo_model.dart';

class TodoViewModel {
  StreamController<List<ToDoModel>> listTodoController =
      StreamController<List<ToDoModel>>();

  Stream<List<ToDoModel>> get listTodoStream => listTodoController.stream;

  void addData(List<ToDoModel> listToDoModel) {
    listTodoController.sink.add(listToDoModel);
  }

  dispose() {
    listTodoController.close();
  }
}
