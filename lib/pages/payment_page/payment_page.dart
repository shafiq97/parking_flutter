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
                  trailing: Text('Floor: ${payment['floor']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
