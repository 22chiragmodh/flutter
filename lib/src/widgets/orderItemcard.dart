import 'package:flutter/material.dart';
import 'package:foodcafe/src/food.dart';
import 'package:get/get.dart';

class OrderItemCard extends StatelessWidget {
  final int index;
  const OrderItemCard({super.key, required this.index});

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
              Container(
                height: 20,
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 4.60),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.25, color: Color(0xFFC13515)),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 10.80,
                      height: 10.80,
                      decoration: ShapeDecoration(
                        color: Color(0xFFC13515),
                        shape: OvalBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '1 X ',
                      style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 16,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    TextSpan(
                      text: '${Foods.foodList[index]['title']}'.tr,
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
          '\$20',
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
