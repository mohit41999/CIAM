// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<ProductModelDatum> data;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        status: json["status"],
        message: json["message"],
        data: List<ProductModelDatum>.from(
            json["data"].map((x) => ProductModelDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ProductModelDatum {
  ProductModelDatum({
    required this.productName,
    required this.productDetails,
    required this.productPrice,
  });

  String productName;
  String productDetails;
  String productPrice;

  factory ProductModelDatum.fromJson(Map<String, dynamic> json) =>
      ProductModelDatum(
        productName: json["product_name"],
        productDetails: json["product_details"],
        productPrice: json["product_price"],
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName,
        "product_details": productDetails,
        "product_price": productPrice,
      };
}
