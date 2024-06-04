import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_car_parking/controller/AuthController.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({super.key});

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
                            _showPaymentModal(context, payment);
                          },
                          child: Text('Pay'),
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

  void _showPaymentModal(BuildContext context, dynamic payment) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return PaymentModal(payment: payment);
      },
    );
  }
}

class PaymentModal extends StatefulWidget {
  final dynamic payment;

  PaymentModal({required this.payment});

  @override
  _PaymentModalState createState() => _PaymentModalState();
}

class _PaymentModalState extends State<PaymentModal> {
  String? selectedBank;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select Bank for Payment'),
            const SizedBox(height: 20),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedBank,
              items: [
                DropdownMenuItem(value: 'Bank A', child: Text('Bank A')),
                DropdownMenuItem(value: 'Bank B', child: Text('Bank B')),
                DropdownMenuItem(value: 'Bank C', child: Text('Bank C')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedBank = value;
                });
              },
              hint: Text('Select Bank'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle payment process
                Navigator.pop(context); // Close the modal after payment
                Get.snackbar('Success', 'Payment processed successfully');
              },
              child: Text('Pay'),
            ),
          ],
        ),
      ),
    );
  }
}
