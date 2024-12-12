import 'package:flutter/material.dart';
import 'package:food_delivery/app/colors.dart';
import 'package:food_delivery/app/dimensions.dart';
import 'package:food_delivery/base/custom_app_bar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/pages/order/view_order.dart';
import 'package:food_delivery/widgets/BigText.dart';
import 'package:get/get.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_isLoggedIn) {
      _tabController = TabController(length: 2, vsync: this);
      Get.find<OrderController>().getOrderList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Đơn hàng của tôi"),
      body: Column(
        children: [
          Container(
            width: Dimensions.screenWidth,
            child: TabBar(
              indicatorColor: AppColors.blackColor,
              indicatorWeight: 3,
              labelColor: AppColors.blackColor,
              // unselectedLabelColor: Theme.of(context).disabledColor,
              unselectedLabelColor: AppColors.unselectedColor,
              controller: _tabController,
              tabs: [
                Tab(
                  text: "Đang vận chuyển",
                ),
                Tab(
                  text: "Lịch sử",
                )
              ],
            ),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: const [
              ViewOrder(isCurrent: true),
              ViewOrder(isCurrent: false),
            ]),
          )
        ],
      ),
    );
  }
}
