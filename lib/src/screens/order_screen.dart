import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodcafe/src/features/apiConstants.dart';
import 'package:foodcafe/src/features/orderlengthProvider.dart';
import 'package:foodcafe/src/food.dart';
import 'package:foodcafe/src/utils/color.dart';
import 'package:foodcafe/src/widgets/ordercard.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with TickerProviderStateMixin {
  bool isDataloading = true;
  late Timer _timer;
  List<Map<String, dynamic>> orderList = [];
  int orderlenth = 0;
  // List<String> statusList = ["Upcoming", "Accepted", "Ready"];
  Future<List<Map<String, dynamic>>> getOrder({String? status}) async {
    try {
      final response = await http.get(
          Uri.parse("${ApiConstants.baseUrl}/order/all?status=$status"),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ${ApiConstants.authToken}',
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);

        // Extract the "data" list from parsedJson
        orderList = List<Map<String, dynamic>>.from(parsedJson['data']);
        // Filter the list based on the "status" field

        print(" 33 ${orderList.length}");

        // setState(() {
        //   isDataloading = false;
        // });

        return orderList;
      }
    } catch (e) {
      return Future.error(e.toString());
    }
    return [];
  }

  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 55), (timer) {
      setState(() {
        getOrder(status: "received");
      });
    });
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _controller!.dispose();
    _timer.cancel();
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> _refreshProducts(
      BuildContext context) async {
    return getOrder(status: "recieved");
  }

  Future<void> updateOrder(String updateStatus, String orderId) async {
    print(orderId);
    try {
      final response = await http.put(
          Uri.parse("${ApiConstants.baseUrl}/order/update-status/$orderId"),
          headers: {
            'Authorization': 'Bearer ${ApiConstants.authToken}',
          },
          body: {
            "status": updateStatus
          });
      if (response.statusCode == 200) {
        setState(() {
          getOrder(status: "received");
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Order Status updated Successfully")));
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_controller!.index);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          // width: MediaQuery.of(context).size.width,
          height: 45,
          padding: const EdgeInsets.all(4),
          decoration: ShapeDecoration(
            color: Color(0xFFEBEBEB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: TabBar(
            controller: _controller,
            labelColor: OrderContainer.selected_tabColor,
            isScrollable: true,
            unselectedLabelColor: OrderContainer.unselected_tabColor,
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontFamily: 'SF Pro',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
            labelStyle: const TextStyle(
              fontSize: 14,
              fontFamily: 'SF Pro',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
            indicator: ShapeDecoration(
              color: Color(0xFFF7F7F7),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: Color(0xFFFF385C),
                ),
                borderRadius: BorderRadius.circular(50),
              ),
            ), //Change background color from here

            tabs: [
              Tab(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Upcoming'.tr,
                        style: TextStyle(
                          color: OrderContainer.unselected_tabColor,
                          fontSize: 14,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      // TextSpan(
                      //   text: ' ($orderlenth)',
                      //   style: TextStyle(
                      //     color: OrderContainer.unselected_tabColor,
                      //     fontSize: 14,
                      //     fontFamily: 'SF Pro',
                      //     fontWeight: FontWeight.w600,
                      //     height: 0,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Tab(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Accepted'.tr,
                        style: TextStyle(
                          color: OrderContainer.unselected_tabColor,
                          fontSize: 14,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      // TextSpan(
                      //   text: ' (${orderList.length})',
                      //   style: TextStyle(
                      //     color: OrderContainer.unselected_tabColor,
                      //     fontSize: 14,
                      //     fontFamily: 'SF Pro',
                      //     fontWeight: FontWeight.w600,
                      //     height: 0,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Tab(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Ready'.tr,
                        style: TextStyle(
                          color: OrderContainer.unselected_tabColor,
                          fontSize: 14,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      // TextSpan(
                      //   text: ' (0)',
                      //   style: TextStyle(
                      //     color: OrderContainer.unselected_tabColor,
                      //     fontSize: 14,
                      //     fontFamily: 'SF Pro',
                      //     fontWeight: FontWeight.w600,
                      //     height: 0,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          // color: Colors.red,
          height: MediaQuery.of(context).size.height - 230,
          child: TabBarView(controller: _controller, children: [
            FutureBuilder(
                future: getOrder(status: "received"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                        child: SvgPicture.asset("assets/images/Empty-bro.svg"));
                  } else {
                    List<Map<String, dynamic>> rOrders = snapshot.data!;
                    orderlenth = rOrders.length;

                    return ListView.builder(
                        itemCount: rOrders.length,
                        itemBuilder: (context, index) {
                          return Ordercard(
                            onupdateOrder: updateOrder,
                            orderItemList: rOrders[index],
                            isHistory: false,
                            status: "Accept",
                          );
                        });
                  }
                }),
            FutureBuilder(
                future: getOrder(status: "accepted"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                        child: SvgPicture.asset("assets/images/Empty-bro.svg"));
                  } else {
                    List<Map<String, dynamic>> acceptOrders = snapshot.data!;
                    return ListView.builder(
                        itemCount: acceptOrders.length,
                        itemBuilder: (context, index) {
                          return Ordercard(
                            onupdateOrder: updateOrder,
                            orderItemList: acceptOrders[index],
                            isHistory: false,
                            status: "Ready",
                          );
                        });
                  }
                }),
            FutureBuilder(
                future: getOrder(status: "ready"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                        child: SvgPicture.asset("assets/images/Empty-bro.svg"));
                  } else {
                    List<Map<String, dynamic>> readyOrders = snapshot.data!;
                    return ListView.builder(
                        itemCount: readyOrders.length,
                        itemBuilder: (context, index) {
                          return Ordercard(
                            onupdateOrder: updateOrder,
                            orderItemList: readyOrders[index],
                            isHistory: false,
                            status: "Delivered",
                          );
                        });
                  }
                }),
          ]),
        ),
      ],
    );
  }
}
