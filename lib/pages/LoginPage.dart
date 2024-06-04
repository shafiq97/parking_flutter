import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_car_parking/components/MyButton.dart';
import 'package:smart_car_parking/components/MyTextField.dart';
import 'package:smart_car_parking/pages/MapPage.dart';

import 'SignUpPage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

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
                  Onchange: emailController,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  icons: Icons.password,
                  lable: "Password",
                  Onchange: passwordController,
                ),
                const SizedBox(height: 90),
                MyButton(
                  icon: Icons.admin_panel_settings_rounded,
                  Btname: "LOGIN",
                  ontap: () {
                    // Use emailController.text and passwordController.text as needed
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
