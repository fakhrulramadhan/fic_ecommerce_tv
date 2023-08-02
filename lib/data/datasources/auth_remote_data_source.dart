//bikin  model, login, regsiter, dan auth response dulu
import 'package:dartz/dartz.dart';
import '../models/login_request_modlel.dart';
import '../models/responses/auth_response_model.dart';
import 'package:fic_ecommerce_tv/data/models/register_request_model.dart';

import 'package:http/http.dart' as http;

import '../../common/global_variable.dart';

class AuthRemoteDataSource {
  //menampilkan kanlau bisa (right) dan kalau error (left),
  //butuh login request model, auth = login
  //fungsi login
  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel model) async {
    final response = await http.post(
      Uri.parse("${GlobalVariables.baseUrl}/auth/local/"),
      headers: <String, String>{
        'Content-Type': 'application/json ; charset=UTF-8'
      },
      body: model.toJson(), //body diisi dari data model form loagin
    );

    if (response.statusCode == 200) {
      //ambil satuan data pakai raw json
      return Right(AuthResponseModel.fromRawJson(response.body));
    } else {
      return const Left("Error Server");
    }
  }

  //fungsi register
  Future<Either<String, AuthResponseModel>> register(
      RegisterRequestModel model) async {
    final response = await http.post(
      Uri.parse("${GlobalVariables.baseUrl}/auth/local/register"),
      headers: <String, String>{
        'Content-Type': 'application/json ; charset=UTF-8'
      },
      body: model.toJson(), //data dari form register (model) yg dikirim
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromRawJson(response.body));
    } else {
      return const Left("Error Server");
    }
  }
}
