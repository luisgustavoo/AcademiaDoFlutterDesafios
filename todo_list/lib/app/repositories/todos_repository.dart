import '../database/connection.dart';
import '../models/todo_model.dart';

class TodosRepository {
  Future<List<TodoModel>> findByPeriod(DateTime start, DateTime end) async {
    final startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    final endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);
    final conn = await Connection().instance;
    final result = await conn.rawQuery('''select * 
                from todo 
              where data_hora between ? and ? 
            order by data_hora''',
        [startFilter.toIso8601String(), endFilter.toIso8601String()]);

    return result.map((t) => TodoModel.fromJson(t)).toList();
  }

  Future<void> saveTodo(DateTime dateTimeTask, String descricao) async {
    final conn = await Connection().instance;
    await conn.rawInsert(
        'insert into todo(descricao, data_hora, finalizado) values (?,?,?)',
        [descricao, dateTimeTask.toIso8601String(), 0]);
  }

  Future<void> checkOrUncheckTodo(TodoModel todo) async {
    final conn = await Connection().instance;
    await conn.rawUpdate('update todo set finalizado = ? where id = ?',
        [todo.finalizado ? 1 : 0, todo.id]);
  }

  Future<void> deleteTodo(TodoModel todoModel) async {
    final conn = await Connection().instance;
    await conn.rawDelete(
        'delete from todo where id = ?',
        [todoModel.id]);
  }
}
