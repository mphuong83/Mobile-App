import 'package:flutter/material.dart';
import 'package:food_delivery/app/colors.dart';
import 'package:food_delivery/app/dimensions.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:get/get.dart';

class PaymentOptionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final int index;
  const PaymentOptionButton(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      bool _selected = orderController.paymentIndex == index;
      return InkWell(
        onTap: () => orderController.setPaymentIndex(index),
        child: Container(
          padding: EdgeInsets.only(bottom: Dimensions.height10 / 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20 / 4),
              // color: Theme.of(context).cardColor,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200]!,
                  blurRadius: 5,
                  spreadRadius: 1,
                )
              ]),
          child: ListTile(
            leading: Icon(
              icon,
              size: 40,
              color: _selected
                  ? AppColors.greenColor
                  : Theme.of(context).disabledColor,
            ),
            title: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: Dimensions.font16,
                fontFamily: "Roboto",
              ),
            ),
            subtitle: Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).disabledColor,
                fontSize: Dimensions.font16 - 2,
                fontFamily: "Roboto",
              ),
            ),
            trailing: _selected
                ? Icon(
                    Icons.check_circle,
                    color: AppColors.greenColor,
                    // color: Colors.green,
                  )
                : null,
          ),
        ),
      );
    });
  }
}
