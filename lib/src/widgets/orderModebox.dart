import 'package:flutter/material.dart';
import 'package:foodcafe/src/utils/color.dart';

class OrderModeBox extends StatelessWidget {
  final String orderMode;
  OrderModeBox({super.key, required this.orderMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: orderMode == "dinein" ? 64 : 87,
      height: 29,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: ShapeDecoration(
        color: orderMode == "dinein"
            ? OrderContainer.orderModeColor2
            : OrderContainer.orderModeColor1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(43),
        ),
      ),
      child: Center(
        child: Text(
          orderMode,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'SF Pro',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ),
    );
  }
}
