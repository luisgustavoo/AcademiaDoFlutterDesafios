import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/todo_model.dart';
import '../../repositories/todos_repository.dart';

class HomeController extends ChangeNotifier {
  final TodosRepository repository;
  int selectedTab = 1;
  DateTime startFilter;
  DateTime endFilter;
  DateTime daySelected;
  Map<String, List<TodoModel>> listTodo = {};
  final dateFormat = DateFormat('dd/MM/yyyy');
  bool deleted = false;
  String error = '';


  HomeController({@required this.repository}) {
    findAllForWeek();
  }

  Future<void> findAllForWeek() async {
    daySelected = DateTime.now();

    startFilter = DateTime.now();
    if (startFilter.weekday != DateTime.monday) {
      startFilter =
          startFilter.subtract(Duration(days: (startFilter.weekday - 1)));
    }
    endFilter = startFilter.add(Duration(days: 6));

    final todos = await repository.findByPeriod(startFilter, endFilter);

    if (todos.isEmpty) {
      listTodo = {dateFormat.format(DateTime.now()): []};
    } else {
      listTodo =
          groupBy(todos, (todoModel) => dateFormat.format(todoModel.dataHora));
    }

    notifyListeners();
  }

  void checkOrUncheck(TodoModel todo) {
    todo.finalizado = !todo.finalizado;
    notifyListeners();
    repository.checkOrUncheckTodo(todo);
  }

  void filterFinalized() {
    listTodo = listTodo.map((key, value) {
      final todosFinalized = value.where((t) => t.finalizado).toList();
      return MapEntry(key, todosFinalized);
    });
    notifyListeners();
  }

  void findTodoBySelectedDay() async {
    final todos = await repository.findByPeriod(daySelected, daySelected);

    if (todos.isEmpty) {
      listTodo = {dateFormat.format(daySelected): []};
    } else {
      listTodo =
          groupBy(todos, (todoModel) => dateFormat.format(todoModel.dataHora));
    }
    notifyListeners();
  }

  void deleteTodo(TodoModel todoModel) async {
    try {
      deleted = false;
      await repository.deleteTodo(todoModel);
      deleted = true;
    } on Exception catch (e) {
      error = 'Erro ao deletar tarefa';
      print(e);
    } finally {
      update();
    }
  }

  void changeSelectedTab(BuildContext context, int index) async {
    selectedTab = index;
    switch (index) {
      case 0:
        filterFinalized();
        break;
      case 1:
        findAllForWeek();
        break;
      case 2:
        var day = await showDatePicker(
            context: context,
            initialDate: daySelected,
            firstDate: DateTime.now().subtract(Duration(days: 360 * 2)),
            lastDate: DateTime.now().add(Duration(days: 360 * 10)));

        if (day != null) {
          daySelected = day;
          findTodoBySelectedDay();
        }

        break;
    }
    notifyListeners();
  }

  void update() {
    switch (selectedTab) {
      case 1:
        findAllForWeek();
        break;
      case 2:
        findTodoBySelectedDay();
        break;
    }
    notifyListeners();
  }
}
