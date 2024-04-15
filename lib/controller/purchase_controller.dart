import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PurchaseController extends GetxController {
  double orderPrice = 0;
  String PGName = '';

  submitOrder({
    required double price,
    required String name,
    required description,
  }) {
    orderPrice = price;
    PGName = name;

    Razorpay _razorpay = Razorpay();
    var options = {
      'key': '<YOUR_KEY_HERE>',
      'amount': price * 100,
      'name': name,
      'description': description,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    Get.snackbar('Success', 'Payment is successfully', colorText: Colors.green);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Get.snackbar('Error', '${response.message}', colorText: Colors.red);
  }
}
