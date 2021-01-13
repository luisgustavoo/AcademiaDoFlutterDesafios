import 'package:flutter/material.dart';
import '../database/connection.dart';

class DatabaseAdministratorConnection extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    var connection = Connection();

    print(state);

    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        connection.closeConnection;
        break;
      case AppLifecycleState.paused:
        connection.closeConnection;
        break;
      case AppLifecycleState.detached:
        connection.closeConnection;
        break;
    }
  }
}
