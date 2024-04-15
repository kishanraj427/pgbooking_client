import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pgbooking_client/controller/purchase_controller.dart';
import 'package:pgbooking_client/model/pg/pg.dart';

class PgDescriptionPage extends StatelessWidget {
  const PgDescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    PG_details pgDetails = Get.arguments['data'];
    return GetBuilder<PurchaseController>(builder: (ctrl) {
      ;
      return Scaffold(
          appBar: AppBar(
            title: const Text('PG Details',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          body: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        pgDetails.image ?? '',
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: 200,
                      )),
                  const SizedBox(height: 20),
                  Text(
                    pgDetails.name ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    pgDetails.description ?? '',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Rs : ${pgDetails.price ?? ''}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: Colors.indigo),
                        child: const Text(
                          'Buy Now',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        onPressed: () {
                          ctrl.submitOrder(
                              price: pgDetails.price ?? 0,
                              name: pgDetails.name ?? '',
                              description: pgDetails.description ?? '');
                        },
                      ))
                ],
              )));
    });
  }
}
