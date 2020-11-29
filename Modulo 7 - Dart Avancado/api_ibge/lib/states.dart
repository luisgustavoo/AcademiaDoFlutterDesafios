import 'package:api_ibge/connection.dart';
import 'package:api_ibge/districts.dart';
import 'package:api_ibge/state_model.dart';
import 'package:dio/dio.dart';
import 'package:mysql1/mysql1.dart';

class States {

   static const  url  = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados';

  Future<List<StateModel>> fetchStatesApi() async {
    try{
      final response = await Dio().get(url);
      return response.data.map<StateModel>((state) => StateModel.fromJson(state)).toList();
    } on DioError catch (e) {
      print(e.message);
      throw e.message;
    }
  }

  Future<void> insertStates() async {
    final conn = await MyConnection.getConnection();
    final districts = Districts();
    final states = await fetchStatesApi();
    states.forEach((state) async {
      try{
        final result = await conn.query('select count(*) as qt from estados where id = ?', [state.id]);
        if(result.first.fields['qt'] as int <= 0) {
          await conn.query(
              'insert into estados (id, sigla, nome) values (?,?,?)',
              [state.id, state.initials, state.name]);
        }
        await districts.insertDistrict(state.id);
      } on MySqlException catch (e){
        print(e.message);
      } finally {
        await conn.close();
      }
    });

  }

}