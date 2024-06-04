import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_car_parking/components/MyButton.dart';
import 'package:smart_car_parking/components/MyTextField.dart';
import 'package:smart_car_parking/controller/AuthController.dart';
import 'package:smart_car_parking/pages/MapPage.dart';

import 'SignUpPage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: const Text("L O G I N"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                MyTextField(
                  icons: Icons.email,
                  lable: "Email id",
                  controller:
                      TextEditingController(text: authController.email.value),
                  onChanged: (value) {
                    authController.setEmail(value);
                  },
                ),
                const SizedBox(height: 10),
                MyTextField(
                  icons: Icons.password,
                  lable: "Password",
                  controller: TextEditingController(
                      text: authController.password.value),
                  onChanged: (value) {
                    authController.setPassword(value);
                  },
                ),
                const SizedBox(height: 90),
                MyButton(
                  icon: Icons.admin_panel_settings_rounded,
                  Btname: "LOGIN",
                  ontap: () {
                    // Use authController.email.value and authController.password.value as needed
                    Get.offAll(const MapPage());
                  },
                ),
                const SizedBox(height: 20),
                MyButton(
                  icon: Icons.person_add,
                  Btname: "SIGN UP",
                  ontap: () {
                    Get.to(const SignupPage()); // Navigate to the SignupPage
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
