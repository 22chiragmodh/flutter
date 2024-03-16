import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String status;
  final Future<void> Function(String, String) onUpdate;
  String orderid;
  CustomButton(
      {super.key,
      required this.status,
      required this.onUpdate,
      required this.orderid});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: ElevatedButton(
          onPressed: () async {
            await widget.onUpdate(
                widget.status == "Accept"
                    ? "accepted"
                    : widget.status == "Ready"
                        ? "ready"
                        : "delivered",
                widget.orderid);
          },
          child: Text(
            widget.status,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'SF Pro',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(widget.status == "Delivered"
                      ? Color(0xFF008A05)
                      : widget.status == "Accept"
                          ? Color(0xFFD33753)
                          : Color(0xFF222222)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              )))),
    );
  }
}
