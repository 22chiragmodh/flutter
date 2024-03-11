import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:foodcafe/src/utils/color.dart';

class ToggleSwitch extends StatefulWidget {
  bool? status;
  ToggleSwitch({super.key, required this.status});

  @override
  State<ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 66,
      height: 50,
      child: Column(
        children: [
          FlutterSwitch(
            activeIcon: Icon(
              Icons.check,
              color: MenuContainer.toogle_activecolor,
            ),
            width: 85.0,
            height: 30,
            activeColor: MenuContainer.toogle_activecolor,
            inactiveColor: MenuContainer.toogle_inactivecolor,

            showOnOff: false,
            valueFontSize: 14.0,
            toggleSize: 35.0,
            value: widget.status!,
            borderRadius: 30.0,
            padding: 8.0,
            // showOnOff: true,
            onToggle: (val) {
              setState(() {
                widget.status = val;
              });
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 4),
            child: Text(
              widget.status! ? 'Available' : "Unavailable",
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 12,
                fontFamily: 'SF Pro',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
