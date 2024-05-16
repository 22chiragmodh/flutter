import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodcafe/src/features/apiConstants.dart';

import 'package:foodcafe/src/utils/color.dart';

import 'package:foodcafe/src/widgets/ordercard.dart';
import 'package:http/http.dart' as http;

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with TickerProviderStateMixin {
  TabController? _controller;
  List<Map<String, dynamic>> orderList = [];
  Future<List<Map<String, dynamic>>> getOrder() async {
    try {
      final response = await http.get(
          Uri.parse("${ApiConstants.baseUrl}/order/all?status=delivered"),
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

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double tabWidth = width / 5;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          height: 45,
          padding: const EdgeInsets.all(4),
          decoration: ShapeDecoration(
            color: Color(0xFFEBEBEB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: TabBar(
            isScrollable: true,
            controller: _controller,

            labelColor: OrderContainer.selected_tabColor,
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
              Tab(text: "Today"),
              Tab(text: "Yesterday"),
              Tab(text: "Weekly"),
              Tab(text: "Monthly"),
            ],
          ),
        ),
        FutureBuilder(
            future: getOrder(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Image.asset("assets/images/noitem.jpg"));
              } else {
                List<Map<String, dynamic>> deliveredOrders = snapshot.data!;

                //today order
                DateTime now = DateTime.now();

                List<Map<String, dynamic>> todayOrders =
                    deliveredOrders.where((order) {
                  DateTime placedAt = DateTime.parse(order['placedAt']);
                  return placedAt.year == now.year &&
                      placedAt.month == now.month &&
                      placedAt.day == now.day;
                }).toList();

//yesterday order
                DateTime yesterday = now.subtract(Duration(days: 1));
                List<Map<String, dynamic>> yesterdayOrders =
                    deliveredOrders.where((order) {
                  DateTime placedAt = DateTime.parse(order['placedAt']);
                  return placedAt.year == yesterday.year &&
                      placedAt.month == yesterday.month &&
                      placedAt.day == yesterday.day;
                }).toList();

//weekly order

                DateTime startOfWeek = DateTime(now.year, now.month, now.day)
                    .subtract(Duration(days: now.weekday - 1));
                DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
                List<Map<String, dynamic>> weeklyOrders =
                    deliveredOrders.where((order) {
                  DateTime placedAt = DateTime.parse(order['placedAt']);
                  return placedAt.isAfter(startOfWeek) &&
                      placedAt.isBefore(endOfWeek);
                }).toList();

                //monthy order

                List<Map<String, dynamic>> monthlyOrders =
                    deliveredOrders.where((order) {
                  DateTime placedAt = DateTime.parse(order['placedAt']);
                  return placedAt.year == now.year &&
                      placedAt.month == now.month;
                }).toList();
                return Container(
                  height: MediaQuery.of(context).size.height - 220,
                  child: TabBarView(controller: _controller, children: [
                    //today orders

                    todayOrders.isEmpty
                        ? Center(
                            child:
                                SvgPicture.asset("assets/images/Empty-bro.svg"))
                        : Container(
                            margin: EdgeInsets.only(bottom: 16),
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                                itemCount: todayOrders.length,
                                itemBuilder: (context, index) {
                                  return Ordercard(
                                    isHistory: true,
                                    status: "Delivered",
                                    orderItemList: todayOrders[index],
                                  );
                                }),
                          ),

                    //yesterday orders

                    yesterdayOrders.isEmpty
                        ? Center(
                            child:
                                SvgPicture.asset("assets/images/Empty-bro.svg"))
                        : Container(
                            margin: EdgeInsets.only(bottom: 16),
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                                itemCount: yesterdayOrders.length,
                                itemBuilder: (context, index) {
                                  return Ordercard(
                                    isHistory: true,
                                    status: "Delivered",
                                    orderItemList: yesterdayOrders[index],
                                  );
                                }),
                          ),

                    //weekly orders

                    weeklyOrders.isEmpty
                        ? Center(
                            child:
                                SvgPicture.asset("assets/images/Empty-bro.svg"))
                        : Container(
                            margin: EdgeInsets.only(bottom: 16),
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                                itemCount: weeklyOrders.length,
                                itemBuilder: (context, index) {
                                  return Ordercard(
                                    isHistory: true,
                                    status: "Delivered",
                                    orderItemList: weeklyOrders[index],
                                  );
                                }),
                          ),
                    //monthly orders

                    monthlyOrders.isEmpty
                        ? Center(
                            child:
                                SvgPicture.asset("assets/images/Empty-bro.svg"))
                        : Container(
                            margin: EdgeInsets.only(bottom: 16),
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                                itemCount: deliveredOrders.length,
                                itemBuilder: (context, index) {
                                  return Ordercard(
                                    isHistory: true,
                                    status: "Delivered",
                                    orderItemList: monthlyOrders[index],
                                  );
                                }),
                          ),
                  ]),
                );
              }
            })
      ],
    );
  }
}
