// To parse this JSON data, do
//
//     final orderRequestModel = orderRequestModelFromJson(jsonString);

//ambil data APInya dari API Create Order / 200 OK Status Order

// To parse this JSON data, do
//
//     final orderRequestModel = orderRequestModelFromJson(jsonString);

import 'dart:convert';

class OrderRequestModel {
  final Data data;

  OrderRequestModel({
    required this.data,
  });

  factory OrderRequestModel.fromRawJson(String str) =>
      OrderRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderRequestModel.fromJson(Map<String, dynamic> json) =>
      OrderRequestModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

//ambil datanya yang cass attributes
// class Data {
//   final int id;
//   final Attributes attributes;

//   Data({
//     required this.id,
//     required this.attributes,
//   });

//   factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["id"],
//         attributes: Attributes.fromJson(json["attributes"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "attributes": attributes.toJson(),
//       };
// }

class Data {
  final List<Item> items;
  final int totalPrice;
  final String deliveryAddress;
  final String courierName;
  final int shippingCost;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  // final DateTime publishedAt;
  final String statusOrder;
  final int userId;

  Data(
      {required this.items,
      required this.totalPrice,
      required this.deliveryAddress,
      required this.courierName,
      required this.shippingCost,
      // required this.createdAt,
      // required this.updatedAt,
      // required this.publishedAt,
      required this.statusOrder,
      required this.userId});

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      totalPrice: json["totalPrice"],
      deliveryAddress: json["deliveryAddress"],
      courierName: json["courierName"],
      shippingCost: json["shippingCost"],
      // createdAt: DateTime.parse(json["createdAt"]),
      // updatedAt: DateTime.parse(json["updatedAt"]),
      // publishedAt: DateTime.parse(json["publishedAt"]),
      statusOrder: json["statusOrder"],
      userId: json["userId"]);

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "totalPrice": totalPrice,
        "deliveryAddress": deliveryAddress,
        "courierName": courierName,
        "shippingCost": shippingCost,
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
        // "publishedAt": publishedAt.toIso8601String(),
        "statusOrder": statusOrder,
        "userId": userId
      };
}

class Item {
  final int id;
  final String productName;
  final int price;
  final int qty;

  Item({
    required this.id,
    required this.productName,
    required this.price,
    required this.qty,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        productName: json["productName"],
        price: json["price"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productName": productName,
        "price": price,
        "qty": qty,
      };
}
