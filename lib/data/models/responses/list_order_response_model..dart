// To parse this JSON Order, do
//
//     final listOrderResponseModel = listOrderResponseModelFromJson(jsonString);

//pakai yang API Create Product / 200 OK statusOrder
import 'dart:convert';

class ListOrderResponseModel {
  List<Order>? data;
  Meta? meta;

  ListOrderResponseModel({
    this.data,
    this.meta,
  });

  factory ListOrderResponseModel.fromRawJson(String str) =>
      ListOrderResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      ListOrderResponseModel(
        // data order diubah ke dalam bentuk list
        data: json["data"] == null
            ? null
            : List<Order>.from(json["data"]!.map((x) => Order.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        //datanya dibuah ke dalam bentuk list (order pesanan lebih
        //dari 1 produk)
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
      };
}

//ubah dari class Order menjadi order, list Order produk
//yang di order ada di class ini
class Order {
  int? id;
  Attributes? attributes;

  Order({
    this.id,
    this.attributes,
  });

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        attributes: json["attributes"] == null
            ? null
            : Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes?.toJson(),
      };
}

class Attributes {
  List<Item>? items;
  int? totalPrice;
  String? deliveryAddress;
  String? courierName;
  int? shippingCost;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? publishedAt;
  String? statusOrder;
  int? userId; //butuh user id utk menampilkan pesanan based per usernya

  Attributes(
      {this.items,
      this.totalPrice,
      this.deliveryAddress,
      this.courierName,
      this.shippingCost,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.statusOrder,
      this.userId});

  factory Attributes.fromRawJson(String str) =>
      Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      totalPrice: json["totalPrice"],
      deliveryAddress: json["deliveryAddress"],
      courierName: json["courierName"],
      shippingCost: json["shippingCost"],
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt:
          json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      publishedAt: json["publishedAt"] == null
          ? null
          : DateTime.parse(json["publishedAt"]),
      statusOrder: json["statusOrder"],
      userId: json["userId"]);

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "totalPrice": totalPrice,
        "deliveryAddress": deliveryAddress,
        "courierName": courierName,
        "shippingCost": shippingCost,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "publishedAt": publishedAt?.toIso8601String(),
        "statusOrder": statusOrder,
        "userId": userId,
      };
}

class Item {
  int? id;
  String? productName;
  int? price;
  int? qty;

  Item({
    this.id,
    this.productName,
    this.price,
    this.qty,
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

class Meta {
  Meta();

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta();

  Map<String, dynamic> toJson() => {};
}
