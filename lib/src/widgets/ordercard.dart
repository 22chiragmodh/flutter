import 'package:flutter/material.dart';
import 'package:foodcafe/src/utils/color.dart';
import 'package:foodcafe/src/widgets/customButton.dart';
import 'package:foodcafe/src/widgets/orderItemcard.dart';

class Ordercard extends StatelessWidget {
  final String status;
  final bool isHistory;
  const Ordercard({
    super.key,
    required this.status,
    required this.isHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isHistory ? 358 : 410,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x1E000000),
            blurRadius: 16,
            offset: Offset(0, 6),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 30,
            // color: Colors.red,
            margin: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'ID: 401',
                  style: TextStyle(
                    color: MenuContainer.toogle_textcolor,
                    fontSize: 20,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                Text(
                  'Deliver by: 8:30 PM',
                  style: TextStyle(
                    color: MenuContainer.toogle_textcolor,
                    fontSize: 14,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            indent: 16,
            endIndent: 16,
            thickness: 1,
          ),
          Container(
            // color: Colors.yellow,
            height: 228,
            margin: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  // color: Colors.red,
                  height: 165,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Order details',
                        style: TextStyle(
                          color: Color(0xFF222222),
                          fontSize: 18,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      Container(
                        height: 140,
                        child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return OrderItemCard(index: index);
                            }),
                      )
                    ],
                  ),
                ),
                Divider(
                  indent: 16,
                  endIndent: 16,
                  thickness: 1,
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  // color: Colors.green,
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total (USD)',
                        style: TextStyle(
                          color: Color(0xFF222222),
                          fontSize: 16,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      Text(
                        '\$2,400',
                        style: TextStyle(
                          color: Color(0xFF222222),
                          fontSize: 16,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          isHistory ? Text("") : CustomButton(status: status)
        ],
      ),
    );
  }
}
