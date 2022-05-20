import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/API%20repo/api_end_points.dart';
import 'package:patient/Models/products_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController {
  late Map<String, dynamic> products;

  Future<ProductModel> getProducts(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await PostData(
            PARAM_URL: AppEndPoints.get_helthcare_and_product,
            params: {'token': Token, 'user_id': prefs.getString('user_id')})
        .then((value) {
      products = value;
    });
    return ProductModel.fromJson(products);
  }
}
