import 'package:flutter/material.dart';
import 'package:food_delivery/app/colors.dart';
import 'package:food_delivery/app/dimensions.dart';
import 'package:food_delivery/base/custom_app_bar.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/widgets/BigText.dart';
import 'package:food_delivery/widgets/account_widget.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:get/get.dart';

import '../../controllers/location_controller.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
        appBar: CustomAppBar(title: "Thông tin cá nhân"),
        body: GetBuilder<UserController>(
          builder: (userController) {
            return userLoggedIn
                ? (userController.isLoading
                    ? const CustomLoader()
                    : Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: Dimensions.height20),
                        child: Column(
                          children: [
                            //profile icon
                            AppIcon(
                              icon: Icons.person,
                              backgroundColor: AppColors.greenColor,
                              iconColor: Colors.white,
                              iconSize:
                                  Dimensions.height45 + Dimensions.height30,
                              size: Dimensions.height15 * 10,
                            ),
                            SizedBox(
                              height: Dimensions.height30,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: Dimensions.width15,
                                      right: Dimensions.width15),
                                  padding: EdgeInsets.only(
                                      top: Dimensions.height10,
                                      bottom: Dimensions.height15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 1,
                                            offset: Offset(0, 3),
                                            color: Colors.grey.withOpacity(0.2))
                                      ],
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius15)),
                                  child: Column(
                                    children: [
                                      //name
                                      AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.person,
                                            backgroundColor: Colors.transparent,
                                            iconColor: Colors.black,
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText: BigText(
                                              text: userController
                                                  .userModel.name)),
                                      SizedBox(
                                        height: Dimensions.height20,
                                      ),
                                      //phone
                                      AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.phone,
                                            backgroundColor: Colors.transparent,
                                            iconColor: Colors.black,
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText: BigText(
                                              text: userController
                                                  .userModel.phone)),
                                      SizedBox(
                                        height: Dimensions.height20,
                                      ),
                                      //email
                                      AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.email,
                                            backgroundColor: Colors.transparent,
                                            iconColor: Colors.black,
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText: BigText(
                                              text: userController
                                                  .userModel.email)),
                                      SizedBox(
                                        height: Dimensions.height20,
                                      ),
                                      //address
                                      GetBuilder<LocationController>(
                                          builder: (locationController) {
                                        if (userLoggedIn &&
                                            locationController
                                                .addressList.isEmpty) {
                                          return GestureDetector(
                                            onTap: () {
                                              Get.offNamed(
                                                  RouteHelper.getAddressPage());
                                            },
                                            child: AccountWidget(
                                                appIcon: AppIcon(
                                                  icon: Icons.location_on,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  iconColor: Colors.black,
                                                  iconSize:
                                                      Dimensions.height10 *
                                                          5 /
                                                          2,
                                                  size: Dimensions.height10 * 5,
                                                ),
                                                bigText:
                                                    BigText(text: "Na/Na")),
                                          );
                                        } else {
                                          return GestureDetector(
                                            onTap: () {
                                              Get.offNamed(
                                                  RouteHelper.getAddressPage());
                                            },
                                            child: AccountWidget(
                                                appIcon: AppIcon(
                                                  icon: Icons.location_on,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  iconColor: Colors.black,
                                                  iconSize:
                                                      Dimensions.height10 *
                                                          5 /
                                                          2,
                                                  size: Dimensions.height10 * 5,
                                                ),
                                                bigText: BigText(
                                                    text: "Địa chỉ của bạn")),
                                          );
                                        }
                                      }),
                                      SizedBox(
                                        height: Dimensions.height20,
                                      ),
                                      //message
                                      AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.message_outlined,
                                            backgroundColor: Colors.transparent,
                                            iconColor: Colors.black,
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText: BigText(text: "Tin nhắn")),
                                      SizedBox(
                                        height: Dimensions.height20,
                                      ),
                                      //message
                                      GestureDetector(
                                        onTap: () {
                                          if (Get.find<AuthController>()
                                              .userLoggedIn()) {
                                            Get.find<AuthController>()
                                                .clearSharedData();
                                            Get.find<CartController>().clear();
                                            Get.find<CartController>()
                                                .clearCartHistory();
                                            Get.offNamed(
                                                RouteHelper.getSignInPage());
                                          } else {
                                            print("Ban da dang xuat");
                                          }
                                        },
                                        child: AccountWidget(
                                            appIcon: AppIcon(
                                              icon: Icons.logout,
                                              backgroundColor:
                                                  Colors.transparent,
                                              iconColor: Colors.black,
                                              iconSize:
                                                  Dimensions.height10 * 5 / 2,
                                              size: Dimensions.height10 * 5,
                                            ),
                                            bigText:
                                                BigText(text: "Đăng Xuất")),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                : Container(
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: Dimensions.height10 * 30,
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/logo.png",
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getSignInPage());
                          },
                          child: Container(
                            width: double.maxFinite,
                            height: Dimensions.height10 * 5,
                            margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                            ),
                            child: Center(
                                child: BigText(
                              text: "Đăng nhập",
                              color: Colors.white,
                              size: Dimensions.font26,
                            )),
                          ),
                        ),
                      ],
                    )),
                  );
          },
        ));
  }
}
