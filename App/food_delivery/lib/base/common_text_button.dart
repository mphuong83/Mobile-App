import 'package:flutter/material.dart';
import 'package:food_delivery/app/colors.dart';
import 'package:food_delivery/app/dimensions.dart';
import 'package:food_delivery/widgets/BigText.dart';

class CommonTextButton extends StatelessWidget {
  final String text;
  const CommonTextButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: Dimensions.height10,
          bottom: Dimensions.height10,
          left: Dimensions.width20,
          right: Dimensions.width20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 10,
              color: AppColors.whiteColor.withOpacity(0.5))
        ],
        borderRadius: BorderRadius.circular(Dimensions.radius20),
        color: AppColors.whiteColor,
      ),
      child: Center(
        child: BigText(
          text: text,
          color: AppColors.blackColor,
        ),
      ),
    );
  }
}
