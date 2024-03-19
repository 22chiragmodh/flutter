import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  List<dynamic>? orderHistory;
  HomeCard({super.key, this.orderHistory});

  @override
  Widget build(BuildContext context) {
    double avg = 0.0;
    print(orderHistory![0]);
    if (orderHistory![0] == 0) {
      avg = 0;
    } else {
      avg = orderHistory![1] / orderHistory![0];
    }
    return SizedBox(
      width: 175,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Today’s sales",
                  style: TextStyle(
                    color: Color(0xFFEBEBEB),
                    fontSize: 12,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                Text(
                  "₹ ${orderHistory![1]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Delivered orders: ',
                        style: TextStyle(
                          color: Color(0xFFEBEBEB),
                          fontSize: 14,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '${orderHistory![0]!}',
                        style: TextStyle(
                          color: Color(0xFFEBEBEB),
                          fontSize: 14,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.bold,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Average order value: ',
                        style: TextStyle(
                          color: Color(0xFFEBEBEB),
                          fontSize: 14,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '₹ $avg',
                        style: TextStyle(
                          color: Color(0xFFEBEBEB),
                          fontSize: 14,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.bold,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
