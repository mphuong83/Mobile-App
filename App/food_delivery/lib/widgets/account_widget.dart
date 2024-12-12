import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/app/dimensions.dart';
import 'package:food_delivery/widgets/BigText.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:get/get.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({super.key, required this.appIcon, required this.bigText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15),
      padding: EdgeInsets.only(
          left: Dimensions.width20, bottom: Dimensions.height10),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black, width: 0.5))
          // color: Colors.white,
          // boxShadow: [
          //   BoxShadow(
          //       blurRadius: 1,
          //       offset: Offset(0, 3),
          //       color: Colors.grey.withOpacity(0.2))
          // ],
          ),
      child: Row(
        children: [
          appIcon,
          SizedBox(
            width: Dimensions.width20,
          ),
          bigText,
        ],
      ),
    );
  }
}
