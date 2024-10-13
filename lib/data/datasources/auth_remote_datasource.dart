import 'dart:convert'; // Tambahkan ini
import 'package:aplikasi_sipos/core/constants/variables.dart';
import 'package:aplikasi_sipos/data/model/response/auth_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

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
      // Ubah bagian ini
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      return right(AuthResponseModel.fromJson(decodedResponse));
    } else {
      return left(response.body);
    }
  }
}
