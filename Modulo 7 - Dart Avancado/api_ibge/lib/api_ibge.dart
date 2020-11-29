import 'package:api_ibge/states.dart';

void run() async {
  print('start');
  final state = States();
  await state.insertStates();
  print('finish');
}
