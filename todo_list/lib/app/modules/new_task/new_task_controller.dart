import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../repositories/todos_repository.dart';

class NewTaskController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final dateFormat = DateFormat('dd/MM/yyyy');
  final TodosRepository repository;
  DateTime daySelected;
  TextEditingController nomeTaskController = TextEditingController();
  bool saved = false;
  bool loading = false;
  String error = '';

  String get dayFormatted => dateFormat.format(daySelected);

  NewTaskController({this.repository, String day}) {
    daySelected = dateFormat.parse(day);
  }

  void save() async {
    try {
      if (formKey.currentState.validate()) {
        saved = false;
        loading = true;
        await repository.saveTodo(daySelected, nomeTaskController.text);
        saved = true;
        loading = false;
      }
    } on Exception catch (e) {
      print(e);
      error = 'Erro ao savar TODO';
    }
    notifyListeners();
  }
}
