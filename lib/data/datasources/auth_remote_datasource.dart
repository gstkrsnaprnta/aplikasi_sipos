import 'dart:convert';
import 'package:aplikasi_sipos/core/constants/variables.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:aplikasi_sipos/data/datasources/auth_local_datasource.dart';
import '../model/response/auth_response_model.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/login'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      return right(AuthResponseModel.fromJson(decodedResponse));
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();

    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/logout'),
      headers: {
        'Authorization': 'Bearer ${authData.token}',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      final message = decodedResponse['message'] ?? 'Logout berhasil';

      await AuthLocalDatasource().removeAuthData();

      return right(message);
    } else {
      return left(response.body);
    }
  }
}
