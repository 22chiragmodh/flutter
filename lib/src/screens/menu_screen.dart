import 'dart:convert';

import 'package:flutter/material.dart';

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
        setState(() {
          isDataloading = false;
        });
      }
      print(menuList);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Non-Veg Menu",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              ToggleSwitch(
                status: true,
              )
            ],
          ),
        ),
        isDataloading
            ? Center(
                child: SizedBox(
                    height: 15, width: 15, child: CircularProgressIndicator()))
            : Container(
                height: MediaQuery.of(context).size.height - 210,
                // color: Colors.red,
                child: ListView.builder(
                    itemCount: menuList.length,
                    itemBuilder: ((context, index) {
                      return ItemCard(
                          isVeg: menuList[index].isVeg,
                          isAvailable: menuList[index].isAvailable,
                          imgUrl: menuList[index].photo,
                          title: menuList[index].name.toString().tr,
                          description: menuList[index].category,
                          price: menuList[index].price,
                          id: menuList[index].id);
                    })),
              )
      ],
    );
  }
}
