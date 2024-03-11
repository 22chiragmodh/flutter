import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String status;

  const CustomButton({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: ElevatedButton(
          onPressed: () {},
          child: Text(
            status,
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
                  MaterialStateProperty.all<Color>(status == "Delivered"
                      ? Color(0xFF008A05)
                      : status == "Accept"
                          ? Color(0xFFD33753)
                          : Color(0xFF222222)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              )))),
    );
  }
}
