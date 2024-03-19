import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodcafe/src/features/apiConstants.dart';
import 'package:foodcafe/src/utils/color.dart';
import 'package:foodcafe/src/widgets/homecard.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> orderList = [];
  late Timer _timer;

  Future<List<dynamic>> getOrder() async {
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

        // Function to check if the order was placed today

        orderList = List<Map<String, dynamic>>.from(parsedJson['data']);

        DateTime now = DateTime.now();
        String today = DateFormat('yyyy-MM-dd').format(now);

        // Filter orders for today
        List<Map<String, dynamic>> todayOrders = orderList.where((order) {
          String placedAt =
              order['placedAt'].substring(0, 10); // Extract YYYY-MM-DD
          return placedAt == today;
        }).toList();

        // Filter the list based on the "status" field
        int totalorders = orderList.length;
        double totalSales = 0.0;
        for (var order in todayOrders) {
          for (var item in order['items']) {
            totalSales += item['price'] * item['quantity'];
          }
          print(totalSales);
        }
        print(" 33 ${orderList.length}");

        // setState(() {
        //   isDataloading = false;
        // });

        return [todayOrders.length, totalSales];
      }
    } catch (e) {
      return Future.error(e.toString());
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 5), (timer) {
      setState(() {
        getOrder();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getOrder(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Image.asset("assets/images/noitem.jpg"));
        } else {
          List<dynamic> ordersHistory = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: Text(
                  'Shiv Caterer’s Cafeteria',
                  style: TextStyle(
                    color: MenuContainer.toogle_textcolor,
                    fontSize: 22,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 2),
                child: Text(
                  'Open Air Theatre, ABV IIITM Gwalior',
                  style: TextStyle(
                    color: MenuContainer.toogle_textcolor,
                    fontSize: 12,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              Container(
                height: 155,
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(0.99, -0.16),
                    end: Alignment(-0.99, 0.16),
                    colors: [Color(0xFFCB3164), Color(0xFFC82E65)],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HomeCard(
                        orderHistory: ordersHistory,
                      ),
                      SizedBox(
                        width: 120,
                        height: 103.41,
                        child: SvgPicture.asset("assets/images/rafiki.svg"),
                      ),
                    ]),
              )
            ],
          );
        }
      },
    );
  }
}
