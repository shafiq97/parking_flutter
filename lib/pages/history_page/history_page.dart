import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_car_parking/controller/AuthController.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking History'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: authController.fetchHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No history found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final record = snapshot.data![index];
                return ListTile(
                  title: Text('License Plate: ${record['plate_number']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Check-in: ${record['check_in_time']}'),
                      Text('Check-out: ${record['check_out_time']}'),
                    ],
                  ),
                  trailing: Text('Extracted: ${record['extracted_characters']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
