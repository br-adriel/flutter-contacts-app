import 'package:dio/dio.dart';
import 'package:flutter_contacts/models/contato.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ContatosB4ARepository {
  final Dio _dio = Dio();

  ContatosB4ARepository() {
    _dio.options.headers["X-Parse-Application-Id"] =
        dotenv.env['BACK4APP_APP_ID'];
    _dio.options.headers["X-Parse-REST-API-Key"] =
        dotenv.env['BACK4APP_API_KEY'];
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = "https://parseapi.back4app.com";
  }

  Future<List<ContatoModel>> listar() async {
    var res = await _dio.get("/classes/Contato");
    var contatos = ContatosListResponse.fromJson(res.data).contatos;
    return contatos;
  }
}
