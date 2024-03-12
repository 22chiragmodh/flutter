import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:foodcafe/src/food.dart';
import 'package:foodcafe/src/utils/color.dart';
import 'package:foodcafe/src/widgets/itemcard.dart';
import 'package:foodcafe/src/widgets/toggle.dart';
import 'package:get/get.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {


  
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
        Container(
          height: MediaQuery.of(context).size.height - 200,
          // color: Colors.red,
          child: ListView.builder(
              itemCount: Foods.foodList.length,
              itemBuilder: ((context, index) {
                return ItemCard(
                  imgUrl: Foods.foodList[index]['imageurl'],
                  title: Foods.foodList[index]['title'].toString().tr,
                  description: Foods.foodList[index]['description'],
                  price: Foods.foodList[index]['price'],
                );
              })),
        )
      ],
    );
  }
}
