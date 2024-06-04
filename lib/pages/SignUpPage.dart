import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'LoginPage.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    TextEditingController studentIdController = TextEditingController();
    TextEditingController licenseNumberController = TextEditingController();
    TextEditingController licensePlateController = TextEditingController();

    Future<void> registerUser() async {
      if (passwordController.text == confirmPasswordController.text) {
        try {
          // Register user with Firebase
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

          // Send additional user data to Flask server
          var response = await http.post(
            Uri.parse('http://10.0.2.2:5001/register'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(<String, String>{
              'userId': userCredential.user?.uid ??
                  '', // Providing a default empty string if user?.uid is null
              'email': emailController.text,
              'studentId': studentIdController.text,
              'licenseNumber': licenseNumberController.text,
              'licensePlate': licensePlateController.text,
            }),
          );

          if (response.statusCode == 200) {
            // Registration successful, show success message
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Success"),
                  content: Text("You have successfully registered."),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage(),
                          ),
                        );
                      },
                      child: Text("OK"),
                    ),
                  ],
                );
              },
            );
          } else {
            // Registration failed, show error message
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Error"),
                  content: Text("Registration failed. Please try again later."),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("OK"),
                    ),
                  ],
                );
              },
            );
          }
        } catch (e) {
          // Handle error and show error message
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("Registration failed. Error: $e"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      } else {
        // Show error message: Passwords do not match
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: Text("S I G N  U P"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email id',
                    icon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    icon: Icon(Icons.password),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    icon: Icon(Icons.password),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: studentIdController,
                  decoration: InputDecoration(
                    labelText: 'Student ID',
                    icon: Icon(Icons.badge),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: licenseNumberController,
                  decoration: InputDecoration(
                    labelText: 'License Number',
                    icon: Icon(Icons.card_membership),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: licensePlateController,
                  decoration: InputDecoration(
                    labelText: 'License Plate',
                    icon: Icon(Icons.directions_car),
                  ),
                ),
                SizedBox(height: 90),
                ElevatedButton(
                  onPressed: registerUser,
                  child: Text("SIGN UP"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
