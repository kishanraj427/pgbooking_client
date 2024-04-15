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
import 'package:pgbooking_client/widgets/multi_select_drop_down%20.dart';
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
                  title: Text(
                    'PG booking',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          GetStorage box = GetStorage();
                          box.erase();
                          Get.offAll(LoginPage);
                        },
                        icon: Icon(Icons.logout))
                  ]),
              body: Column(children: [
                SizedBox(
                  height: 50,
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
                Row(children: [
                  Flexible(
                      child: DropDownBtn(
                    items: ['Rs: Low to high', 'Rs: High to Low'],
                    selectedItemText: 'sort',
                    selectedValue: ctrl.sortBy.value,
                    OnSelected: (selected) {
                      ctrl.sortBy.value = selected ?? 'Rs: Low to high';
                      ctrl.sortByPrice(
                          ascending:
                              selected == 'Rs: Low to high' ? true : false);
                    },
                  )),
                  Flexible(
                      child: MultiSelectDropDown(
                    items: const ['1bed', '2bed', '3bed', '4bed'],
                    onSelectionChanged: (selectedItems) {
                      ctrl.filterByRoom(selectedItems.cast<int>());
                    },
                  ))
                ]),
                SingleChildScrollView(
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
                )
              ])));
    });
  }
}
