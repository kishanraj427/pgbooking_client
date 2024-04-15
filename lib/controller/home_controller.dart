import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgbooking_client/model/pg/pg.dart';
import 'package:pgbooking_client/model/pg_category/pg_category.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference pgCollection;
  late CollectionReference categoryCollection;
  RxString sortBy = 'Rs: Low to high'.obs;
  RxString filerBycate = 'Women'.obs;
  RxString filterByroom = '4Bed'.obs;
  List<PG_details> pgdetail = [];
  List<PG_details> pgshowinUI = [];

  List<PG_category> pgcategory = [];

  Future<void> onInit() async {
    // TODO: implement onInit
    pgCollection = firestore.collection('PG_detail');
    categoryCollection = firestore.collection('category');
    await fetchCategory();
    await fetchPG();
    super.onInit();
  }

  fetchCategory() async {
    try {
      QuerySnapshot categorySnapshot = await categoryCollection.get();
      final List<PG_category> retrievedcategory = categorySnapshot.docs
          .map(
              (doc) => PG_category.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      pgcategory.clear();
      pgcategory.assignAll(retrievedcategory);
      pgshowinUI.assignAll(pgdetail);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    } finally {
      update();
    }
  }

  fetchPG() async {
    try {
      QuerySnapshot pgSnapshot = await pgCollection.get();
      final List<PG_details> retrievepg = pgSnapshot.docs
          .map((doc) => PG_details.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      pgdetail.clear();
      pgdetail.assignAll(retrievepg);
      pgshowinUI.assignAll(pgdetail);
      // Get.snackbar('Success', 'PG detail fetch successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    } finally {
      update();
    }
  }

  filterByCategory(String category) {
    pgshowinUI.clear();
    pgdetail =
        pgdetail.where((pgDetails) => pgDetails.category == category).toList();
    update();
  }

  filterByRoom(List<int> rooms) {
    if (rooms.isEmpty) {
      pgshowinUI = pgdetail;
    } else {
      // ignore: unused_local_variable
      List<int> Room = rooms.map((room) => room).toList();
      pgshowinUI =
          pgdetail.where((pgDetails) => pgDetails.room == rooms).toList();
    }
    update();
  }

  sortByPrice({required bool ascending}) {
    List<PG_details> sortedPg = List<PG_details>.from(pgshowinUI);
    sortedPg.sort((a, b) => ascending
        ? a.price!.compareTo(b.price!)
        : b.price!.compareTo(a.price!));
    pgshowinUI = sortedPg;
    update();
  }
}
