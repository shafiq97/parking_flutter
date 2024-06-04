import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_car_parking/controller/PakingController.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../config/colors.dart';

class BookingPage extends StatelessWidget {
  final String slotName;
  final String slotId;
  const BookingPage({super.key, required this.slotId, required this.slotName});

  Future<void> _payNow(ParkingController parkingController) async {
    const url = 'http://10.0.2.2:5001/payments'; // Replace with your Flask URL
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': parkingController.name.text,
        'vehicalNumber': parkingController.vehicalNumber.text,
        'slotId': slotId,
        'slotName': slotName,
        'parkingTimeInMin': parkingController.parkingTimeInMin.value,
        'amount': parkingController.parkingAmount.value,
        'floor': parkingController.floor.value,
      }),
    );

    if (response.statusCode == 200) {
      // Handle success
      Get.snackbar('Success', 'Payment successful');
    } else {
      // Handle error
      Get.snackbar('Error', 'Payment failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    ParkingController parkingController = Get.put(ParkingController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        title: const Text(
          "BOOK SLOT",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/animation/running_car.json',
                      width: 300,
                      height: 200,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text(
                      "Book Now 😊",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                const Divider(
                  thickness: 1,
                  color: blueColor,
                ),
                const SizedBox(height: 30),
                const Row(
                  children: [
                    Text(
                      "Enter your name ",
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: parkingController.name,
                        decoration: const InputDecoration(
                          fillColor: lightBg,
                          filled: true,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.person,
                            color: blueColor,
                          ),
                          hintText: "Shafiq",
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                const Row(
                  children: [
                    Text(
                      "Enter Vehical Number ",
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: parkingController.vehicalNumber,
                        decoration: const InputDecoration(
                          fillColor: lightBg,
                          filled: true,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.car_rental,
                            color: blueColor,
                          ),
                          hintText: "ABC 123",
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                const Row(
                  children: [
                    Text(
                      "Enter Floor Number ",
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: parkingController.floor,
                        decoration: const InputDecoration(
                          fillColor: lightBg,
                          filled: true,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.location_city,
                            color: blueColor,
                          ),
                          hintText: "1",
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text(
                      "Choose Slot Time (in Minuits)",
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Slider(
                    mouseCursor: MouseCursor.defer,
                    thumbColor: blueColor,
                    activeColor: blueColor,
                    inactiveColor: lightBg,
                    label: "${parkingController.parkingTimeInMin.value} min",
                    value: parkingController.parkingTimeInMin.value,
                    onChanged: (v) {
                      parkingController.parkingTimeInMin.value = v;
                      if (v <= 30) {
                        parkingController.parkingAmount.value = 30;
                      } else {
                        parkingController.parkingAmount.value = 60;
                      }
                    },
                    divisions: 5,
                    min: 10,
                    max: 60,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("10"),
                      Text("20"),
                      Text("30"),
                      Text("40"),
                      Text("50"),
                      Text("60"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Your Slot Name",
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      height: 80,
                      decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          slotName,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Row(
                          children: [
                            Text("Amount to Be Pay"),
                          ],
                        ),
                        Row(
                          children: [
                            Obx(
                              () => Text(
                                "RM ${parkingController.parkingAmount.value}",
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                  color: blueColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        _payNow(parkingController);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 20),
                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "PAY NOW",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
