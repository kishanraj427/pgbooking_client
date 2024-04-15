import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pgbooking_client/controller/login_controller.dart';
import 'package:pgbooking_client/pages/login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
            const Text('create your Account !!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                )),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: ctrl.registeremailctrl,
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
            TextField(
              keyboardType: TextInputType.name,
              controller: ctrl.registerNamectrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.email),
                labelText: 'Name',
                hintText: 'Enter your Name',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ctrl.addUser();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple,
              ),
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Get.to(const LoginPage());
              },
              child: const Text('Login'),
            )
          ],
        ),
      ));
    });
  }
}
