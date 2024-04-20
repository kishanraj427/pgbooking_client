import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pgbooking_client/controller/home_controller.dart';
import 'package:pgbooking_client/model/pg/pg.dart';
import 'package:pgbooking_client/pages/login_page.dart';
import 'package:pgbooking_client/pages/pg_description_page.dart';
import 'package:pgbooking_client/widgets/dropdown_btn.dart';
import 'package:pgbooking_client/widgets/product_card.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});
  String dummyUrl =
      "https://webstockreview.net/images/clipart-home-cartoon-12.png";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
          onRefresh: () async {
            ctrl.fetchCategory();
          },
          child: Scaffold(
              appBar: AppBar(
                  title: const Text(
                    'PG Booking',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                        onPressed: () {
                          GetStorage box = GetStorage();
                          box.erase();
                          Get.back();
                        },
                        icon: const Icon(Icons.logout, semanticLabel: "Logout"))
                  ]),
              body: Column(children: [
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: ctrl.pgcategory.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                ctrl.filterByCategory(
                                    ctrl.pgcategory[index].gender ?? '');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Chip(
                                    label: Text(ctrl.pgcategory[index].gender ??
                                        'Error')),
                              ));
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(children: [
                    Flexible(
                        child: DropDownBtn(
                      items: const ['Low to high', 'High to low'],
                      selectedItemText: 'sort',
                      selectedValue: ctrl.sortBy.value,
                      OnSelected: (selected) {
                        ctrl.sortBy.value = selected ?? 'Low to high';
                        ctrl.sortByPrice(
                            ascending:
                                selected == 'Low to high' ? true : false);
                      },
                    )),
                    Flexible(
                        child: DropDownBtn(
                      items: const ['1 Bed', '2 Bed', '3 Bed', '4 Bed'],
                      selectedItemText: 'sort',
                      selectedValue: ctrl.roomType.value,
                      OnSelected: (selected) {
                        ctrl.roomType.value = selected ?? '1 Bed';
                        ctrl.filterByRoom(selected ?? "1 Bed");
                      },
                    ))
                  ]),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (PG_details pg_details in ctrl.pgshowinUI) ...[
                          PgCard(
                              name: pg_details.name ?? 'No name',
                              imageurl: pg_details.image ?? dummyUrl,
                              price: pg_details.price ?? 00,
                              adderess: pg_details.place ?? 'No address',
                              onTap: () {
                                Get.to(PgDescriptionPage(),
                                    arguments: {'data': pg_details});
                              })
                        ]
                      ],
                    ),
                  ),
                )
              ])));
    });
  }
}
