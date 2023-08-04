//ambil data APInya dari API Create Order / 200 OK Midtrans

// To parse this JSON data, do
//
//     final orderResponseModel = orderResponseModelFromJson(jsonString);

import 'dart:convert';

class OrderResponseModel {
  final String token;
  final String redirectUrl;

  OrderResponseModel({
    required this.token,
    required this.redirectUrl,
  });

  factory OrderResponseModel.fromRawJson(String str) =>
      OrderResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  // factory OrderResponseModel.fromJson(Map<String, dynamic> json) =>
  //     OrderResponseModel(
  //       token: json["token"],
  //       redirectUrl: json["redirect_url"],
  //     );

  factory OrderResponseModel.fromMap(Map<String, dynamic> map) {
    return OrderResponseModel(
        token: map['token'] ?? '', redirectUrl: map['redirectUrl']);
  }

  factory OrderResponseModel.fromJson(String source) =>
      OrderResponseModel.fromMap(json.decode(source));

  Map<String, dynamic> toJson() => {
        "token": token,
        "redirect_url": redirectUrl,
      };
}
