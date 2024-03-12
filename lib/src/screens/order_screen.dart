import 'package:flutter/material.dart';
import 'package:foodcafe/src/food.dart';
import 'package:foodcafe/src/utils/color.dart';
import 'package:foodcafe/src/widgets/ordercard.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with TickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
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
              Tab(text: "Upcoming orders(3)"),
              Tab(text: "Accepted orders(5)"),
            ],
          ),
        ),
        Container(
          // color: Colors.red,
          height: MediaQuery.of(context).size.height - 220,
          child: TabBarView(controller: _controller, children: [
            ListView.builder(
                itemCount: Foods.foodList.length,
                itemBuilder: (context, index) {
                  return Ordercard(
                    isHistory: false,
                    status: "Accept",
                  );
                }),
            ListView.builder(
                itemCount: Foods.foodList.length,
                itemBuilder: (context, index) {
                  return Ordercard(
                    isHistory: false,
                    status: "Delivered",
                  );
                }),
          ]),
        ),
      ],
    );
  }
}
