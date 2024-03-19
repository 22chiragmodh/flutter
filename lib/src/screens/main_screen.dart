import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:foodcafe/src/features/apiConstants.dart';
import 'package:foodcafe/src/screens/feedback_screen.dart';
import 'package:foodcafe/src/screens/history_screen.dart';
import 'package:foodcafe/src/screens/home_screen.dart';
import 'package:foodcafe/src/screens/menu_screen.dart';
import 'package:foodcafe/src/screens/order_screen.dart';
import 'package:foodcafe/src/utils/color.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool status = true;
  int _selectedIndex = 0;
  bool restroStatus = false;
  bool isTranslatedToHindi = false;

  final List<Widget> pages = [
    HomeScreen(
      key: PageStorageKey('Page1'),
    ),
    MenuScreen(
      key: PageStorageKey('Page2'),
    ),
    OrdersScreen(
      key: PageStorageKey('Page3'),
    ),
    FeedbackScreen(
      key: PageStorageKey('Page4'),
    ),
    HistoryScreen(
      key: PageStorageKey('Page5'),
    ),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleLanguage() {
    print(isTranslatedToHindi);
    if (isTranslatedToHindi) {
      var locale = Locale('en', 'US');
      Get.back();
      Get.updateLocale(locale);
    } else {
      var locale = Locale('hi', 'IN');
      Get.back();
      Get.updateLocale(locale);
    }
    setState(() {
      isTranslatedToHindi = !isTranslatedToHindi;
    });
  }

  @override
  void initState() {
    super.initState();
    getRestaurantStatus();
  }

  Future<void> getRestaurantStatus() async {
    try {
      final response = await http
          .get(Uri.parse("${ApiConstants.baseUrl}/restaurant"), headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${ApiConstants.authToken}',
      });

      if (response.statusCode == 200) {
        // Extract the "data" list from parsedJson
        Map<String, dynamic> parsedJson = jsonDecode(response.body);
        setState(() {
          restroStatus = parsedJson['isOpen'];
        });
        print(restroStatus);

        // setState(() {
        //   isDataloading = false;
        // });
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<void> updateRestaurantStatus(bool updateStatus) async {
    try {
      final response = await http.put(
          Uri.parse("${ApiConstants.baseUrl}/restaurant/status"),
          headers: {
            // "Content-Type": "application/json",
            'Authorization': 'Bearer ${ApiConstants.authToken}',
          },
          body: {
            "isOpen": "$updateStatus"
          });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Restro Status updated Successfully")));
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Color translateIconColor = isTranslatedToHindi ? Colors.red : Colors.black;
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 28,
                offset: Offset(0, -2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            selectedItemColor: MenuContainer.bottom_nav_selectedtextcolor,
            unselectedItemColor: MenuContainer.bottom_nav_unselectedtextcolor,
            selectedLabelStyle: TextStyle(
                color: MenuContainer.bottom_nav_selectedtextcolor,
                fontSize: 10,
                fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(
                color: MenuContainer.bottom_nav_unselectedtextcolor,
                fontSize: 10,
                fontWeight: FontWeight.w600),
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/House.svg",
                  color: _selectedIndex == 0
                      ? MenuContainer.bottom_nav_selectedtextcolor
                      : MenuContainer.bottom_nav_unselectedtextcolor,
                ),
                label: 'Home'.tr,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/Book.svg",
                  color: _selectedIndex == 1
                      ? MenuContainer.bottom_nav_selectedtextcolor
                      : MenuContainer.bottom_nav_unselectedtextcolor,
                ),
                label: 'Menu'.tr,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/Swap.svg",
                  color: _selectedIndex == 2
                      ? MenuContainer.bottom_nav_selectedtextcolor
                      : MenuContainer.bottom_nav_unselectedtextcolor,
                ),
                label: 'Orders'.tr,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/HandPalm.svg",
                  color: _selectedIndex == 3
                      ? MenuContainer.bottom_nav_selectedtextcolor
                      : MenuContainer.bottom_nav_unselectedtextcolor,
                ),
                label: 'Feedback'.tr,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/ClockCounterClockwise.svg",
                  color: _selectedIndex == 4
                      ? MenuContainer.bottom_nav_selectedtextcolor
                      : MenuContainer.bottom_nav_unselectedtextcolor,
                ),
                label: 'History'.tr,
              ),
            ],
          ),
        ),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(54),
            child: Container(
              decoration: BoxDecoration(
                color: MenuContainer.background,
                boxShadow: [
                  BoxShadow(
                    color: MenuContainer.appbarcolor,
                    blurRadius: 16,
                    offset: Offset(0, 6),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: AppBar(
                leadingWidth: 135,
                backgroundColor: MenuContainer.background,
                shadowColor: MenuContainer.appbarcolor,
                leading: Container(
                  margin: EdgeInsets.only(left: 16),
                  child: FlutterSwitch(
                    activeIcon: Icon(
                      Icons.check,
                      color: MenuContainer.toogle_activecolor,
                    ),
                    width: 110.0,
                    activeText: "Online".tr,
                    activeColor: MenuContainer.toogle_activecolor,
                    inactiveColor: MenuContainer.toogle_inactivecolor,
                    activeTextColor: MenuContainer.toogle_textcolor,
                    inactiveTextColor: MenuContainer.toogle_textcolor,
                    activeTextFontWeight: FontWeight.w500,
                    inactiveTextFontWeight: FontWeight.w500,
                    inactiveText: "Offline".tr,
                    showOnOff: true,
                    valueFontSize: 14.0,
                    toggleSize: 40.0,
                    value: restroStatus,
                    borderRadius: 30.0,
                    padding: 8.0,
                    // showOnOff: true,
                    onToggle: (val) async {
                      await updateRestaurantStatus(val);
                      setState(() {
                        restroStatus = val;
                      });
                    },
                  ),
                ),
                actions: [
                  IconButton(
                      icon: SvgPicture.asset("assets/images/Translate.svg",
                          color: translateIconColor),
                      onPressed: _toggleLanguage),
                  IconButton(
                      icon: SvgPicture.asset("assets/images/Bell.svg"),
                      onPressed: () {}),
                  IconButton(
                      icon: SvgPicture.asset("assets/images/UserCircle.svg"),
                      onPressed: () {}),
                ],
              ),
            )),
        body: PageStorage(bucket: bucket, child: pages[_selectedIndex]));
  }
}
