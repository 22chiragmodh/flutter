import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:foodcafe/src/features/apiConstants.dart';
import 'package:foodcafe/src/models/menuModel.dart';

import 'package:foodcafe/src/widgets/itemcard.dart';
import 'package:foodcafe/src/widgets/toggle.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isDataloading = true;
  List<MenuItem> menuList = [];
  List<String> categories = [];
  Map<String, List<MenuItem>> itemsByCategory = {};
  Future<void> getMenu() async {
    try {
      final response = await http
          .get(Uri.parse("${ApiConstants.baseUrl}/menu/restro"), headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${ApiConstants.authToken}',
      });
      if (response.statusCode == 200) {
        List<dynamic> decodedList = json.decode(response.body);
        menuList = decodedList.map((menu) => MenuItem.fromJson(menu)).toList();

// get all unique categories
        categories = getUniqueCategories(menuList);

//seprate items basis on categories
        for (var category in categories) {
          itemsByCategory[category] =
              menuList.where((item) => item.category == category).toList();
        }
        print(itemsByCategory);
        setState(() {
          isDataloading = false;
        });
      }
      print(menuList);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  List<String> getUniqueCategories(List<MenuItem> menuItems) {
    Set<String> uniqueCategories = {};
    for (var item in menuItems) {
      uniqueCategories.add(item.category);
    }
    return uniqueCategories.toList();
  }

  @override
  void initState() {
    super.initState();
    getMenu();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          //   height: 50,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "Non-Veg Menu",
          //         style: TextStyle(
          //           color: Colors.black,
          //           fontSize: 18,
          //           fontFamily: 'SF Pro',
          //           fontWeight: FontWeight.w600,
          //           height: 0,
          //         ),
          //       ),
          //       ToggleSwitch(
          //         status: true,
          //       )
          //     ],
          //   ),
          // ),
          // isDataloading
          //     ? Center(
          //         child: SizedBox(
          //             height: 15, width: 15, child: CircularProgressIndicator()))
          //     : Container(
          //         height: MediaQuery.of(context).size.height - 190,
          //         // color: Colors.red,
          //         child: ListView.builder(
          //             itemCount: menuList.length,
          //             itemBuilder: ((context, index) {
          //               return ItemCard(
          //                   isVeg: menuList[index].isVeg,
          //                   isAvailable: menuList[index].isAvailable,
          //                   imgUrl: menuList[index].photo,
          //                   title: menuList[index].name.toString().tr,
          //                   description: menuList[index].category,
          //                   price: menuList[index].price,
          //                   id: menuList[index].id);
          //             })),
          //       )

          isDataloading
              ? Center(
                  child: SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator()))
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final items = itemsByCategory[category] ?? [];
                    return ExpandablePanel(
                        header: Container(
                          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                          height: 60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 200,
                                child: Text(
                                  category,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'SF Pro',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                              ),
                              SizedBox(width: 30),
                              ToggleSwitch(
                                status: true,
                              )
                            ],
                          ),
                        ),
                        collapsed: const Text(""),
                        expanded: SingleChildScrollView(
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: items.length,
                                itemBuilder: (context, innerIndex) {
                                  final item = items[innerIndex];
                                  return ItemCard(
                                      isVeg: item.isVeg,
                                      isAvailable: item.isAvailable,
                                      imgUrl: item.photo,
                                      title: item.name.toString().tr,
                                      description: item.category,
                                      price: item.price,
                                      id: item.id);
                                })));
                  })
        ],
      ),
    );
  }
}
