import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodcafe/src/widgets/toggle.dart';

class ItemCard extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String description;
  final double price;
  final bool isAvailable;
  final bool isVeg;
  final String id;
  const ItemCard(
      {super.key,
      required this.imgUrl,
      required this.title,
      required this.description,
      required this.price,
      required this.isAvailable,
      required this.isVeg,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: MediaQuery.of(context).size.width,
      // color: Colors.green,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // color: Colors.yellow,
            width: 260,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 74,
                  height: 74,
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(imgUrl),
                        fit: BoxFit.fill,
                      )),
                ),
                Container(
                    width: 168,
                    // color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isVeg
                            ? Image.asset("assets/images/veg.png")
                            : Image.asset("assets/images/nonveg.png"),
                        Text(
                          title,
                          style: TextStyle(
                            color: Color(0xFF222222),
                            fontSize: 16,
                            fontFamily: 'SF Pro',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        Text(
                          description,
                          style: TextStyle(
                            color: Color(0xFF5E5E5E),
                            fontSize: 10,
                            fontFamily: 'SF Pro',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                        Text(
                          "₹ $price",
                          style: TextStyle(
                            color: Color(0xFF222222),
                            fontSize: 14,
                            fontFamily: 'SF Pro',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 5),
              width: 64,
              height: 70,
              child: ToggleSwitch(
                itemId: id,
                status: isAvailable,
              ))
        ],
      ),
    );
  }
}
