import 'package:flutter/material.dart';
import 'package:foodcafe/src/food.dart';
import 'package:foodcafe/src/utils/color.dart';
import 'package:foodcafe/src/widgets/homecard.dart';
import 'package:foodcafe/src/widgets/ordercard.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with TickerProviderStateMixin {
  TabController? _controller;

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
        Container(
          // color: Colors.red,
          height: MediaQuery.of(context).size.height - 220,
          child: TabBarView(controller: _controller, children: [
            // today
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    height: 145,
                    width: MediaQuery.of(context).size.width,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.99, -0.16),
                        end: Alignment(-0.99, 0.16),
                        colors: [Color(0xFFCB3164), Color(0xFFC82E65)],
                      ),
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
                    child: HomeCard(),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: Foods.foodList.length,
                      itemBuilder: (context, index) {
                        return Ordercard(
                          isHistory: true,
                          status: "Accept",
                        );
                      }),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: Foods.foodList.length,
                      itemBuilder: (context, index) {
                        return Ordercard(
                          isHistory: true,
                          status: "Delivered",
                        );
                      }),
                ],
              ),
            ),
            Text("Yesterday"),
            Text("weekly"),
            Text("monthly"),
          ]),
        )
      ],
    );
  }
}
