import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../new_task/new_task_page.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final controller = context.read<HomeController>();

      controller.addListener(() {
        if (controller.error.isNotEmpty) {
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text(controller.error)));

        }

        if (controller.deleted) {
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text('Tarefa excluída com sucesso!')));
          controller.deleted = false;
        }

        /*if (controller.loading) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              });
        }*/
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    context.read<HomeController>().removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, _) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Atividades da Semana',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: controller.listTodo?.keys?.length ?? 0,
              itemBuilder: (context, index) {
                var dateFormat = DateFormat('dd/MM/yyyy');
                var listTodos = controller.listTodo;
                var dayKey = listTodos.keys.elementAt(index);
                var day = dayKey;
                var todos = listTodos[dayKey];
                var today = DateTime.now();

                if (todos.isEmpty && controller.selectedTab == 0) {
                  return SizedBox.shrink();
                }

                if (dayKey == dateFormat.format(today)) {
                  day = 'HOJE';
                } else if (dayKey ==
                    dateFormat.format(today.add(Duration(days: 1)))) {
                  day = 'AMANHÃ';
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            day,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              color: Theme.of(context).primaryColor,
                              size: 30,
                            ),
                            onPressed: () async {
                              await Navigator.of(context).pushNamed(
                                  NewTaskPage.routeName,
                                  arguments: dayKey);
                              controller.update();
                            },
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          var todo = todos[index];
                          return ListTile(
                            onLongPress: () => showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Excluir'),
                                    content: Text(
                                      'Deseja excluir a tarefa?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: Text(
                                          'Cancelar',
                                          style: TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          controller.deleteTodo(todo);
                                        },
                                        child: Text(
                                          'Excluir',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                            leading: Checkbox(
                              activeColor: Theme.of(context).primaryColor,
                              value: todo.finalizado,
                              onChanged: (value) =>
                                  controller.checkOrUncheck(todo),
                            ),
                            title: Text(
                              todo.descricao,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  decoration: todo.finalizado
                                      ? TextDecoration.lineThrough
                                      : null),
                            ),
                            trailing: Text(
                              '''${todo.dataHora.hour.toString().padLeft(2, '0')}:${todo.dataHora.minute.toString().padLeft(2, '0')}''',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  decoration: todo.finalizado
                                      ? TextDecoration.lineThrough
                                      : null),
                            ),
                          );
                        }),
                  ],
                );
              },
            ),
          ),
          bottomNavigationBar: FFNavigationBar(
            selectedIndex: controller.selectedTab,
            items: [
              FFNavigationBarItem(
                iconData: Icons.check_circle,
                label: 'Finalizado',
              ),
              FFNavigationBarItem(
                iconData: Icons.view_week,
                label: 'Semanal',
              ),
              FFNavigationBarItem(
                iconData: Icons.calendar_today,
                label: 'Slecionar Data',
              ),
            ],
            onSelectTab: (index) =>
                controller.changeSelectedTab(context, index),
            theme: FFNavigationBarTheme(
                itemWidth: 60,
                barHeight: 70,
                barBackgroundColor: Theme.of(context).primaryColor,
                unselectedItemIconColor: Colors.white,
                unselectedItemLabelColor: Colors.white,
                selectedItemBorderColor: Colors.white,
                selectedItemIconColor: Colors.white,
                selectedItemBackgroundColor: Theme.of(context).primaryColor,
                selectedItemLabelColor: Colors.black),
          ),
        );
      },
    );
  }
}
