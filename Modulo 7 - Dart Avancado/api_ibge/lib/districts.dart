import 'package:api_ibge/connection.dart';
import 'package:api_ibge/district_model.dart';
import 'package:dio/dio.dart';
import 'package:mysql1/mysql1.dart';

class Districts {
  static const  url  = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados/{uf}/distritos';

  Future<List<DistrictModel>> fetchDistrictApi(int id) async {
    try{
      final response = await Dio().get(url.replaceAll('{uf}', id.toString()));
      return response.data.map<DistrictModel>((district) => DistrictModel.fromJson(district)).toList();
    } on DioError catch (error) {
      print(error.message);
      throw error.message;
    }
  }

  Future<void> insertDistrict(int idState) async {
    final conn = await MyConnection.getConnection();

    final districts = await fetchDistrictApi(idState);

    for(var district in districts){
      try{
        final result = await conn.query('select count(*) as qt from distritos where id = ?', [district.id]);
        if(result.first.fields['qt'] as int <= 0) {
          await conn.query(
              'insert into distritos (id, nome, id_estado) values (?,?,?)',
              [district.id, district.name, idState]);
        }
      } on MySqlException catch (error){
        print(error.message);
        throw error.message;
      } finally {
        await conn.close();
      }
    }


  }
}