import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:foodcafe/src/features/apiConstants.dart';
import 'package:foodcafe/src/models/menuModel.dart';
import 'package:foodcafe/src/utils/color.dart';

import 'package:foodcafe/src/widgets/itemcard.dart';
import 'package:foodcafe/src/widgets/toggle.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isDataloading = true;
  List<MenuItem> menuList = [];
  List<String> categories = [];

  bool categoryStatus = true;
  Map<String, List<MenuItem>> itemsByCategory = {};
  Map<String, bool> categoryStatusMap = {};
  ExpandableController? controller;
  Future<void> getMenu() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

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

        for (var category in categories) {
          categoryStatusMap[category] = prefs.getBool(category) ?? true;
        }

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
      // print(menuList);
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

  Future<void> updateCategoryMenu(
      bool updateStatus, List<MenuItem> items, String category) async {
    try {
      for (var item in items) {
        final response = await http.put(
          Uri.parse("${ApiConstants.baseUrl}/menu/update-status/${item.id}"),
          headers: {
            'Authorization': 'Bearer ${ApiConstants.authToken}',
          },
          body: {"isAvailable": "$updateStatus"},
        );

        if (response.statusCode == 200) {
          print("Success");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool(category, updateStatus);
        }
      }

      setState(() {
        getMenu();
      });
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isDataloading
              ? const Center(
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
                        controller: controller,
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
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'SF Pro',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                              ),
                              SizedBox(width: 30),

                              // category toggle

                              Container(
                                width: 70,
                                height: 55,
                                child: Column(
                                  children: [
                                    FlutterSwitch(
                                      activeIcon: Icon(
                                        Icons.check,
                                        color: MenuContainer.toogle_activecolor,
                                      ),
                                      width: 85.0,
                                      height: 30,
                                      activeColor:
                                          MenuContainer.toogle_activecolor,
                                      inactiveColor:
                                          MenuContainer.toogle_inactivecolor,

                                      showOnOff: false,
                                      valueFontSize: 14.0,
                                      toggleSize: 35.0,
                                      value:
                                          categoryStatusMap[category] ?? true,
                                      borderRadius: 30.0,
                                      padding: 8.0,
                                      // showOnOff: true,
                                      onToggle: (val) async {
                                        setState(() {
                                          categoryStatusMap[category] = val;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Menu status updated Successfully")),
                                        );
                                        await updateCategoryMenu(
                                            val, items, category);
                                      },
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 4),
                                      child: Text(
                                        categoryStatusMap[category] ?? true
                                            ? 'Available'
                                            : "Unavailable",
                                        style: TextStyle(
                                          color: Color(0xFF222222),
                                          fontSize: 12,
                                          fontFamily: 'SF Pro',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
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
