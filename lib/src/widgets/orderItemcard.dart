import 'package:flutter/material.dart';
import 'package:foodcafe/src/food.dart';
import 'package:get/get.dart';

class OrderItemCard extends StatelessWidget {
  final Map<String, dynamic> items;
  const OrderItemCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              items['isVeg']
                  ? Image.asset("assets/images/veg.png")
                  : Image.asset("assets/images/nonveg.png"),
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${items['quantity']} X ',
                      style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 16,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    TextSpan(
                      text: '${items['name']}'.tr,
                      style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 16,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Text(
          '₹ ${items['price']}',
          style: TextStyle(
            color: Color(0xFF5E5E5E),
            fontSize: 14,
            fontFamily: 'SF Pro',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
      ],
    );
  }
}
