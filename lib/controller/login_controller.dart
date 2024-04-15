import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pgbooking_client/pages/home_page.dart';

import '../model/user/user.dart';

class LoginController extends GetxController {
  final box = GetStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;

  TextEditingController registerNamectrl = TextEditingController();
  TextEditingController registeremailctrl = TextEditingController();
  TextEditingController loginemailctrl = TextEditingController();

  User? LoginUser;
  void onReady() {
    Map<String, dynamic>? user = box.read('LoginUser');
    if (user != null) {
      Get.to(HomePage());
    }
  }

  void onInit() {
    userCollection = firestore.collection('users');
    super.onInit();
  }

  addUser() {
    try {
      if (registerNamectrl.text.isEmpty || registeremailctrl.text.isEmpty) {
        Get.snackbar('error', 'Please fill the field', colorText: Colors.red);
        return;
      }
      DocumentReference doc = userCollection.doc();
      User user = User(
          id: doc.id,
          name: registerNamectrl.text,
          email: registeremailctrl.text);
      // ignore: unused_local_variable
      final userJson = user.toJson();
      doc.set(user);
      Get.snackbar('success', 'user added succeccfully',
          colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    }
  }

  Future<void> loginWithemail() async {
    try {
      String email = loginemailctrl.text;
      if (email.isNotEmpty) {
        var querrySnapshot = await userCollection
            .where('email', isEqualTo: email)
            .limit(1)
            .get();
        if (querrySnapshot.docs.isNotEmpty) {
          var userDoc = querrySnapshot.docs.first;
          var userData = userDoc.data() as Map<String, dynamic>;
          box.write('LoginUser', userData);
          loginemailctrl.clear();
          Get.to(HomePage());
          Get.snackbar('Success', 'Login Successful', colorText: Colors.green);
        } else {
          Get.snackbar('Error', 'User not found, please register',
              colorText: Colors.red);
        }
      } else {
        Get.snackbar('error', 'please enter the email id',
            colorText: Colors.red);
      }
    } catch (error) {
      print('failed to Login');
    }
  }
}
