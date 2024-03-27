import 'package:flutter/material.dart';
import 'package:foodcafe/src/utils/color.dart';
import 'package:foodcafe/src/widgets/customButton.dart';
import 'package:foodcafe/src/widgets/orderItemcard.dart';
import 'package:foodcafe/src/widgets/orderModebox.dart';
import 'package:intl/intl.dart';

class Ordercard extends StatefulWidget {
  final String status;
  final bool isHistory;
  Map<String, dynamic>? orderItemList;
  final Future<void> Function(String, String)? onupdateOrder;

  Ordercard(
      {super.key,
      required this.status,
      required this.isHistory,
      this.orderItemList,
      this.onupdateOrder});

  @override
  State<Ordercard> createState() => _OrdercardState();
}

class _OrdercardState extends State<Ordercard> {
  double totalPrice = 0.0;
  String deliveredTime = "";

  String convertUtcToFormattedTime(String utcTimestamp) {
    DateTime dateTime = DateTime.parse(utcTimestamp).toLocal();
    String formattedTime = DateFormat.jm().format(dateTime);
    return formattedTime;
  }

  void initState() {
    super.initState();

    totalPrice = (widget.orderItemList!['items'] as List)
        .map<double>((item) =>
            (item['price'] is int
                ? (item['price'] as int).toDouble()
                : item['price']) *
            (item['quantity'] as int))
        .fold(0, (previousValue, element) => previousValue + element);

    deliveredTime =
        convertUtcToFormattedTime(widget.orderItemList!['placedAt']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: isHistory ? 358 : 410,
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
            height: 48,
            // color: Colors.red,
            margin: EdgeInsets.all(16),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID: ${widget.orderItemList!['id']}',
                      style: TextStyle(
                        color: MenuContainer.toogle_textcolor,
                        fontSize: 20,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        'Deliver by: $deliveredTime',
                        style: TextStyle(
                          color: MenuContainer.toogle_textcolor,
                          fontSize: 14,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
                widget.orderItemList!['orderMode'] == null
                    ? Text("")
                    : OrderModeBox(
                        orderMode: widget.orderItemList!['orderMode'])
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
            // height: 228,
            margin: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  // color: Colors.red,
                  height:
                      35.0 * widget.orderItemList!['items'].length.toDouble() +
                          30.0,
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
                        // color: Colors.red,
                        height: 35.0 *
                            widget.orderItemList!['items'].length.toDouble(),
                        child: ListView.builder(
                            itemCount: widget.orderItemList!['items'].length,
                            itemBuilder: (context, index) {
                              return OrderItemCard(
                                items: widget.orderItemList!['items'][index],
                              );
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
                        '₹ $totalPrice',
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
          widget.isHistory
              ? Text("")
              : CustomButton(
                  status: widget.status,
                  onUpdate: widget.onupdateOrder!,
                  orderid: widget.orderItemList!['_id'],
                )
        ],
      ),
    );
  }
}
