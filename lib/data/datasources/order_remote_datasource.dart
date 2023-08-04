import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fic_ecommerce_tv/data/datasources/auth_local_datasource.dart';
import 'package:fic_ecommerce_tv/data/models/order_request_model.dart';
import 'package:fic_ecommerce_tv/data/models/responses/list_order_response_model..dart';
import '../models/responses/order_response_model.dart';
import 'package:http/http.dart' as http;

import '../../common/global_variable.dart';

class OrderRemoteDataSource {
  //nama fieldnya diiisi string, dana datanya diisi oleh order
  //model, Left tipenya string, right tipenya model

  //membutuhkan parameter order requestmodel (utk menangkap data inputan
  //order dari user)
  Future<Either<String, OrderResponseModel>> order(
      OrderRequestModel model) async {
    final tokenJwt = await AuthLocalDataSource().getToken();
    print(model.toRawJson());
    final response = await http.post(
      Uri.parse("${GlobalVariables.baseUrl}/orders"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $tokenJwt',
        // 'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjg5NTEyNDk2LCJleHAiOjE2OTIxMDQ0OTZ9.2XiSFe4KhRr0nZirO1LUTU9qlNwFiTsxzxSPzNes00Y'
        // 'Authorization':
        //     'Bearer 54349b59-98ce-4fc5-9aaa-bd4c45c17f0f"' //dari api/orders
      },
      body: model.toRawJson(),
    );

    if (response.statusCode == 200) {
      //error di modelnya
      return Right(OrderResponseModel.fromJson(response.body));
    } else {
      return const Left("Error Server");
    }
  }

  //untuk mendapatkan data barang orderan berdasarkan id user (per user)
  //enngak usah pakai parameter di dalam kurungnya
  Future<Either<String, ListOrderResponseModel>> listOrder() async {
    //dapatin data user yang login dulu
    final authData = await AuthLocalDataSource().getAuthData();
    final response = await http.post(
        Uri.parse(
            "${GlobalVariables.baseUrl}/orders?filters[userId][\$eq]=${authData.user.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${{authData.jwt}}' //jwt = token
        });

    //left kalau error, right kalau sukses (status codenya)
    if (response.statusCode == 200) {
      return Right(ListOrderResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Left("Server Error");
    }
  }
}
