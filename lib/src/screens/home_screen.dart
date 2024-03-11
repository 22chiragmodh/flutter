import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodcafe/src/utils/color.dart';
import 'package:foodcafe/src/widgets/homecard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(0.99, -0.16),
              end: Alignment(-0.99, 0.16),
              colors: [Color(0xFFCB3164), Color(0xFFC82E65)],
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            const HomeCard(),
            SizedBox(
              width: 123,
              height: 103.41,
              child: SvgPicture.asset("assets/images/rafiki.svg"),
            ),
          ]),
        )
      ],
    );
  }
}
