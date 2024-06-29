import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_car_parking/controller/AuthController.dart';
import 'package:smart_car_parking/pages/payment_page/payment_option.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({super.key});

  Future<Map<String, dynamic>?> createBill(dynamic payment) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Get.snackbar('Error', 'User not logged in');
      return null;
    }

    final url = Uri.parse('http://10.0.2.2:5001/create-bill');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'billName': 'Car Rental ${payment['slot_name']}',
        'billDescription':
            'Car Rental ${payment['slot_name']} on ${payment['date']}',
        'billAmount': 1,
        'billReturnUrl': 'https://www.uniten.edu.my/',
        'billCallbackUrl': 'https://www.uniten.edu.my/',
        'billExternalReferenceNo': 'REF12345',
        'billTo': user.displayName ?? 'John Doe',
        'billEmail': user.email,
        'billPhone': '0123456789',
        'billExpiryDate': '17-12-2024 17:00:00',
        'billExpiryDays': 3,
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.isNotEmpty
          ? jsonResponse[0] as Map<String, dynamic>
          : null;
    } else {
      Get.snackbar('Error', 'Failed to create bill');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: authController.fetchPayments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No payments found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final payment = snapshot.data![index];
                return ListTile(
                  title: Text('Slot: ${payment['slot_name']}'),
                  subtitle: Text('Amount: RM${payment['amount']}'),
                  trailing: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Floor: ${payment['floor']}'),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PaymentOptionsPage(payment: payment),
                              ),
                            );
                          },
                          child: const Text('Pay'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
