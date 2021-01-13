import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'app/database/connection.dart';
import 'app/database/database_administrator_connection.dart';
import 'app/modules/home/home_controller.dart';
import 'app/modules/home/home_page.dart';
import 'app/modules/new_task/new_task_controller.dart';
import 'app/modules/new_task/new_task_page.dart';
import 'app/repositories/todos_repository.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final databaseAdministratorConnection = DatabaseAdministratorConnection();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider(create: (_) => TodosRepository())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xFFFF9129),
          buttonColor: Color(0xFFFF9129),
          textTheme: GoogleFonts.robotoTextTheme(),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          NewTaskPage.routeName: (_) => ChangeNotifierProvider(
              create: (context) {
                final day = ModalRoute.of(_).settings.arguments;
                return NewTaskController(
                    repository: context.read<TodosRepository>(), day: day);
              },
              child: NewTaskPage())
        },
        home: ChangeNotifierProvider(
            create: (context) {
              //var repository = Provider.of<TodosRepository>(context);
              final repository = context.read<TodosRepository>();
              return HomeController(repository: repository);
            },
            child: HomePage()),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Connection().instance;
    WidgetsBinding.instance.addObserver(databaseAdministratorConnection);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(databaseAdministratorConnection);
  }
}
