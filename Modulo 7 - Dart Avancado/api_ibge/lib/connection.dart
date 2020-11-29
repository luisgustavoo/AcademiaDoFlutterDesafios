
import 'package:mysql1/mysql1.dart';

class MyConnection {

  static Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: 'api_ibge',
        db: 'api_ibge');

    try{
      return await MySqlConnection.connect(settings);
    } on MySqlException catch (e){
      print(e.message);
      throw e.message;
    }
  }
}
