import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;

  void setEmail(String value) {
    email.value = value;
  }

  void setPassword(String value) {
    password.value = value;
  }

  Future<List<dynamic>> fetchPayments() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:5002/payments/${email.value}'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load payments');
    }
  }

  Future<List<dynamic>> fetchHistory() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:5002/history/${email.value}'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load history');
    }
  }
}
