import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgbooking_client/controller/login_controller.dart';
import 'package:pgbooking_client/pages/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
      return Scaffold(
        body: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Welcome Back!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    )),
                const SizedBox(height: 20),
                TextField(
                  controller: ctrl.loginemailctrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.email),
                    labelText: 'Email Adderess',
                    hintText: 'Enter your email adderess',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ctrl.loginWithemail();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Text('Login'),
                ),
                TextButton(
                    onPressed: () {
                      Get.to(RegisterPage());
                    },
                    child: const Text('Register new account'))
              ],
            )),
      );
    });
  }
}
