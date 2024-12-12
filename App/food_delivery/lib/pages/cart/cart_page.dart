import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/common_text_button.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/models/place_order_model.dart';
import 'package:food_delivery/pages/order/delivery_option.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/pages/order/payment_option_button.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:get/get.dart';

import '../../app/app_constants.dart';
import '../../app/colors.dart';
import '../../app/dimensions.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/location_controller.dart';
import '../../widgets/BigText.dart';
import '../../widgets/SmallText.dart';
import '../../widgets/app_icon.dart';
import '../home/main_food_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController = TextEditingController();
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: Dimensions.width20 * 3,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getInitial());
                        },
                        child: AppIcon(
                          icon: Icons.arrow_back_ios,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.blackColor,
                          iconSize: Dimensions.iconSize24,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width20 * 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getInitial());
                        },
                        child: AppIcon(
                          icon: Icons.home_outlined,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.blackColor,
                          iconSize: Dimensions.iconSize24,
                        ),
                      ),
                      AppIcon(
                        icon: Icons.shopping_cart,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.blackColor,
                        iconSize: Dimensions.iconSize24,
                      )
                    ])),
            GetBuilder<CartController>(builder: (_cartController) {
              return _cartController.getItems.length > 0
                  ? Positioned(
                      top: Dimensions.height20 * 5,
                      left: Dimensions.height20,
                      right: Dimensions.width20,
                      bottom: 0,
                      child: Container(
                          margin: EdgeInsets.only(top: Dimensions.height15),
                          //color: Colors.red,
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: GetBuilder<CartController>(
                                builder: (cartController) {
                              var _cartList = cartController.getItems;
                              return ListView.builder(
                                  itemCount: _cartList.length,
                                  itemBuilder: (_, index) {
                                    return Container(
                                        width: double.maxFinite,
                                        height: Dimensions.height20 * 5,
                                        child: Row(children: [
                                          GestureDetector(
                                            onTap: () {
                                              var popularIndex = Get.find<
                                                      PopularProductController>()
                                                  .popularProductList
                                                  .indexOf(_cartList[index]
                                                      .product!);
                                              if (popularIndex >= 0) {
                                                Get.toNamed(
                                                    RouteHelper.getPopularFood(
                                                        popularIndex,
                                                        "cartpage"));
                                              } else {
                                                var recommendedIndex = Get.find<
                                                        RecommendedProductController>()
                                                    .recommendedProductList
                                                    .indexOf(_cartList[index]
                                                        .product!);
                                                if (recommendedIndex < 0) {
                                                  Get.snackbar(
                                                    "Lịch sử mua hàng",
                                                    "Không có sẵn lịch sử mua hàng",
                                                    backgroundColor:
                                                        AppColors.mainColor,
                                                    colorText: Colors.white,
                                                  );
                                                } else {
                                                  Get.toNamed(RouteHelper
                                                      .getRecommendedFood(
                                                          recommendedIndex,
                                                          "Giỏ Hàng"));
                                                }
                                              }
                                            },
                                            child: Container(
                                                width: Dimensions.height20 * 5,
                                                height: Dimensions.height20 * 5,
                                                margin: EdgeInsets.only(
                                                    bottom: Dimensions
                                                        .height10),
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            AppConstants
                                                                    .BASE_URL +
                                                                AppConstants
                                                                    .UPLOAD_URL +
                                                                cartController
                                                                    .getItems[
                                                                        index]
                                                                    .img!)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radius20),
                                                    color: Colors.white)),
                                          ),
                                          SizedBox(
                                            width: Dimensions.width10,
                                          ),
                                          Expanded(
                                              child: Container(
                                                  height:
                                                      Dimensions.height20 * 5,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      BigText(
                                                        text: cartController
                                                            .getItems[index]
                                                            .name!,
                                                        color: Colors.black54,
                                                      ),
                                                      SmallText(text: "Cay"),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            BigText(
                                                              text: cartController
                                                                  .getItems[
                                                                      index]
                                                                  .price
                                                                  .toString(),
                                                              color: Colors
                                                                  .redAccent,
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets.only(
                                                                  top: Dimensions
                                                                      .height10,
                                                                  bottom: Dimensions
                                                                      .height10,
                                                                  left: Dimensions
                                                                      .width20,
                                                                  right: Dimensions
                                                                      .width10),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          Dimensions
                                                                              .radius20),
                                                                  color: Colors
                                                                      .white),
                                                              child: Row(
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      cartController.addItem(
                                                                          _cartList[index]
                                                                              .product!,
                                                                          -1);
                                                                      print(
                                                                          "Xoá");
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .remove,
                                                                      color: AppColors.blackColor,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: Dimensions
                                                                            .width10 /
                                                                        2,
                                                                  ),
                                                                  BigText(
                                                                    text: _cartList[
                                                                            index]
                                                                        .quantity
                                                                        .toString(),
                                                                  ),
                                                                  SizedBox(
                                                                    width: Dimensions
                                                                            .width10 /
                                                                        2,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      cartController.addItem(
                                                                          _cartList[index]
                                                                              .product!,
                                                                          1);
                                                                      print(
                                                                          "Thêm");
                                                                    },
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      color: AppColors.blackColor,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ])
                                                    ],
                                                  )))
                                        ]));
                                  });
                            }),
                          )))
                  : const NoDataPage(text: "Giỏ hàng bạn đang trống!");
            })
          ],
        ),
        bottomNavigationBar: GetBuilder<OrderController>(
          builder: (orderController) {
            _noteController.text = orderController.foodNote;
            return GetBuilder<CartController>(
              builder: (cartController) {
                return Container(
                  height: Dimensions.bottomHeightBar,
                  padding: EdgeInsets.only(
                      top: Dimensions.height10,
                      bottom: Dimensions.height10,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  decoration: BoxDecoration(
                      color: AppColors.buttonBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius20 * 2),
                          topRight: Radius.circular(Dimensions.radius20 * 2))),
                  child: cartController.getItems.length > 0
                      ? Column(children: [
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    top: Dimensions.height10,
                                    bottom: Dimensions.height10,
                                    left: Dimensions.width20,
                                    right: Dimensions.width20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20),
                                    color: Colors.white),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: Dimensions.width10 / 2,
                                    ),
                                    BigText(
                                        text: cartController.totalAmount
                                                .toString() +
                                            "\đ"),
                                    SizedBox(
                                      width: Dimensions.width10 / 2,
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () => showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (_) {
                                          return Column(
                                            children: [
                                              Expanded(
                                                child: SingleChildScrollView(
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.9,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  Dimensions
                                                                      .radius20),
                                                          topRight:
                                                              Radius.circular(
                                                                  Dimensions
                                                                      .radius20)),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          // height: 520,
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: Dimensions
                                                                .width20,
                                                            right: Dimensions
                                                                .width20,
                                                            top: Dimensions
                                                                .height20,
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const PaymentOptionButton(
                                                                icon:
                                                                    Icons.money,
                                                                title:
                                                                    "Thanh toán khi nhận hàng",
                                                                subtitle:
                                                                    "Vui lòng thanh toán khi nhận hàng",
                                                                index: 0,
                                                              ),
                                                              SizedBox(
                                                                height: Dimensions
                                                                    .height10,
                                                              ),
                                                              const PaymentOptionButton(
                                                                icon: Icons
                                                                    .payment,
                                                                title:
                                                                    "Thanh toán bằng thẻ",
                                                                subtitle:
                                                                    "Phương thức thanh toán nhanh gọn và an toàn",
                                                                index: 1,
                                                              ),
                                                              SizedBox(
                                                                height: Dimensions
                                                                    .height30,
                                                              ),
                                                              Text(
                                                                "Phương thức giao hàng",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Roboto",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        Dimensions
                                                                            .font20),
                                                              ),
                                                              SizedBox(
                                                                height: Dimensions
                                                                        .height10 /
                                                                    2,
                                                              ),
                                                              DeliveryOption(
                                                                  value:
                                                                      "delivery",
                                                                  title:
                                                                      "Giao hàng tận nhà",
                                                                  amount: double.parse(Get
                                                                          .find<
                                                                              CartController>()
                                                                      .totalAmount
                                                                      .toString()),
                                                                  isFree:
                                                                      false),
                                                              SizedBox(
                                                                height: Dimensions
                                                                        .height10 /
                                                                    2,
                                                              ),
                                                              const DeliveryOption(
                                                                  value:
                                                                      "take away",
                                                                  title:
                                                                      "Mang đi",
                                                                  amount: 10.0,
                                                                  isFree: true),
                                                              SizedBox(
                                                                height: Dimensions
                                                                    .height20,
                                                              ),
                                                              Text(
                                                                "Ghi chú",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Roboto",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        Dimensions
                                                                            .font20),
                                                              ),
                                                              AppTextField(
                                                                textController:
                                                                    _noteController,
                                                                hintText: '',
                                                                icon:
                                                                    Icons.note,
                                                                maxLines: false,
                                                              ),
                                                              SizedBox(
                                                                height: Dimensions
                                                                    .height20,
                                                              ),
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    if (Get.find<
                                                                            AuthController>()
                                                                        .userLoggedIn()) {
                                                                      // print("Đăng nhập?");
                                                                      // print("click");
                                                                      if (Get.find<
                                                                              LocationController>()
                                                                          .addressList
                                                                          .isEmpty) {
                                                                        Get.toNamed(
                                                                            RouteHelper.getAddressPage());
                                                                      } else {
                                                                        var location =
                                                                            Get.find<LocationController>().getUserAddress();
                                                                        var cart =
                                                                            Get.find<CartController>().getItems;
                                                                        var user =
                                                                            Get.find<UserController>().userModel;
                                                                        PlaceOrderBody
                                                                            placeOrder =
                                                                            PlaceOrderBody(
                                                                          cart:
                                                                              cart,
                                                                          orderAmount:
                                                                              100.0,
                                                                          orderNote:
                                                                              orderController.foodNote,
                                                                          address:
                                                                              location.address,
                                                                          latitude:
                                                                              location.latitude,
                                                                          longitude:
                                                                              location.longitude,
                                                                          contactPersonNumber:
                                                                              user.phone,
                                                                          contactPersonName:
                                                                              user.name,
                                                                          scheduleAt:
                                                                              '',
                                                                          distance:
                                                                              10.0,
                                                                          orderType:
                                                                              orderController.orderType,
                                                                          paymentMethod: orderController.paymentIndex == 0
                                                                              ? 'cash_on_delivery'
                                                                              : 'digital_payment',
                                                                        );
                                                                        Get.find<OrderController>().placeOrder(
                                                                            placeOrder,
                                                                            _callback);
                                                                      }
                                                                    } else {
                                                                      Get.toNamed(
                                                                          RouteHelper
                                                                              .getSignInPage());
                                                                    }
                                                                    //popularProduct.addItem(product);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets.only(
                                                                        top: Dimensions
                                                                            .height10,
                                                                        bottom: Dimensions
                                                                            .height10,
                                                                        left: Dimensions
                                                                            .width20,
                                                                        right: Dimensions
                                                                            .width20),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                            offset: Offset(
                                                                                0, 5),
                                                                            blurRadius:
                                                                                10,
                                                                            color:
                                                                                AppColors.whiteColor.withOpacity(0.5))
                                                                      ],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              Dimensions.radius20),
                                                                      color: AppColors
                                                                          .greenColor,
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          BigText(
                                                                        text:
                                                                            "Xác nhận thanh toán",
                                                                        color: AppColors
                                                                            .whiteColor,
                                                                      ),
                                                                    ),
                                                                  ))
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        })
                                    .whenComplete(() =>
                                        orderController.setFoodNote(
                                            _noteController.text.trim())),
                                child: const SizedBox(
                                  // width: double.maxFinite,
                                  child: CommonTextButton(
                                    text: "Thanh toán",
                                  ),
                                ),
                              ),
                            ],
                          )
                        ])
                      : Container(),
                );
              },
            );
          },
        ));
  }

  void _callback(bool isSuccess, String message, String orderID) {
    if (isSuccess) {
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreference();
      Get.find<CartController>().addToHistory();

      if (Get.find<OrderController>().paymentIndex == 0) {
        Get.offNamed(RouteHelper.getOrderSuccessPage(orderID, "success"));
      } else {
        Get.offNamed(RouteHelper.getPaymentPage(
            orderID, Get.find<UserController>().userModel.id));
      }
    } else {
      showCustomSnackBar(message);
    }
  }
}
