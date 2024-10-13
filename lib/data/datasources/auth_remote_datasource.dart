import 'package:aplikasi_sipos/core/constants/variables.dart';
import 'package:aplikasi_sipos/data/model/response/auth_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
    String email,
    String password,
  ) async {
    final response =
        await http.post(Uri.parse('${Variables.baseUrl}/api/login'), body: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      return right(AuthResponseModel.fromJson(response.body as Map<String, dynamic>));
    } else {
      return left(response.body);
    }
  }
}
