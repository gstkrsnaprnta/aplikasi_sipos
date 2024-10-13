import 'dart:convert';
import 'package:aplikasi_sipos/core/constants/variables.dart';
import 'package:aplikasi_sipos/data/datasources/auth_local_datasource.dart';
import 'package:aplikasi_sipos/data/model/response/product_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getProduct() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse("${Variables.baseUrl}/api/products"),
      headers: {
        'Authorization': 'Bearer ${authData.token}',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      return right(ProductResponseModel.fromJson(decodedResponse));
    } else {
      return left(response.body);
    }
  }
}
