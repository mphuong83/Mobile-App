import 'package:flutter/material.dart';
import 'package:food_delivery/app/colors.dart';
import 'package:food_delivery/app/dimensions.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:get/get.dart';

class DeliveryOption extends StatelessWidget {
  final String value;
  final String title;
  final double amount;
  final bool isFree;
  const DeliveryOption({
    super.key,
    required this.value,
    required this.title,
    required this.amount,
    required this.isFree,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return Row(
        children: [
          Radio(
            value: value,
            groupValue: orderController.orderType,
            onChanged: (String? value) =>
                orderController.setDeliveryType(value!),
            // activeColor: Theme.of(context).primaryColor,
            activeColor: AppColors.greenColor,
          ),
          SizedBox(
            width: Dimensions.width10 / 2,
          ),
          Text(
            title,
            style: TextStyle(fontFamily: "Roboto"),
          ),
          SizedBox(
            width: Dimensions.width10 / 2,
          ),
          Text(
              '(${(value == "take aways" || isFree) ? 'free' : '${amount / 10}đ'})',
              style: TextStyle(
                fontFamily: "Roboto",
              )),
        ],
      );
    });
  }
}
