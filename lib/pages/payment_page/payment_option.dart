import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smart_car_parking/pages/payment_page/payment_web_view.dart';

class PaymentOptionsPage extends StatefulWidget {
  final dynamic payment;

  PaymentOptionsPage({super.key, required this.payment});

  @override
  _PaymentOptionsPageState createState() => _PaymentOptionsPageState();
}

class _PaymentOptionsPageState extends State<PaymentOptionsPage> {
  String? selectedBank;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Payment Option'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select Bank for Payment'),
            const SizedBox(height: 20),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedBank,
              items: const [
                DropdownMenuItem(value: 'Bank A', child: Text('Bank A')),
                DropdownMenuItem(value: 'Bank B', child: Text('Bank B')),
                DropdownMenuItem(value: 'Bank C', child: Text('Bank C')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedBank = value;
                });
              },
              hint: const Text('Select Bank'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final billResponse = await createBill(widget.payment);
                if (billResponse != null &&
                    billResponse.containsKey('BillCode')) {
                  final billUrl =
                      'https://dev.toyyibpay.com/${billResponse['BillCode']}';
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentWebView(url: billUrl),
                    ),
                  );
                } else {
                  Get.snackbar('Error', 'Failed to retrieve bill code');
                }
              },
              child: const Text('Pay'),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> createBill(dynamic payment) async {
    final url = Uri.parse('http://10.0.2.2:5001/create-bill');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'billName': 'Car Rental ${payment['slot_name']}',
        'billDescription':
            'Car Rental ${payment['slot_name']} on ${payment['date']}',
        'billAmount': 1,
        'billReturnUrl': 'http://yourapp.com',
        'billCallbackUrl': 'http://yourapp.com/paystatus',
        'billExternalReferenceNo': 'REF12345',
        'billTo': 'John Doe',
        'billEmail': 'john@example.com',
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
}
