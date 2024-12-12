import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:food_delivery/base/custom_app_bar.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../../app/colors.dart';
import '../../app/dimensions.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/address_model.dart';
import '../../routes/route_helper.dart';
import '../../widgets/BigText.dart';
import '../../widgets/app_text_field.dart';
import 'pick_address_map.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  double _currentZoom = 17.0;
  LatLng _initialPosition = const LatLng(20.968846, 105.764670);
  late LatLng _cameraPosition = _initialPosition;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getUserAddressFromLocalStorage() ==
          "") {
        Get.find<LocationController>()
            .saveUserAddress(Get.find<LocationController>().addressList.last);
      }
      Get.find<LocationController>().getUserAddress();
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      );
      _cameraPosition = _initialPosition;
    }
  }

  Future<void> _openPickAddressMap() async {
    final pickedAddress = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PickAddressMap(
          fromSignup: false,
          fromAddress: true,
          mapController: _mapController,
        ),
      ),
    );

    if (pickedAddress != null && pickedAddress is String) {
      setState(() {
        _addressController.text = pickedAddress;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Thêm địa chỉ"),
      body: GetBuilder<UserController>(builder: (userController) {
        if (userController.userModel != null &&
            _contactPersonName.text.isEmpty) {
          _contactPersonName.text = '${userController.userModel?.name}';
          _contactPersonNumber.text = '${userController.userModel?.phone}';
          if (Get.find<LocationController>().addressList.isNotEmpty) {
            _addressController.text =
                Get.find<LocationController>().getUserAddress().address;
          }
        }
        return GetBuilder<LocationController>(builder: (locationController) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 2, color: AppColors.mainColor),
                  ),
                  child: Stack(
                    children: [
                      FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          center: _initialPosition,
                          zoom: _currentZoom,
                          onTap: (tapPosition, latlng) {
                            _openPickAddressMap(); // Mở bản đồ để chọn địa chỉ
                          },
                          onPositionChanged: (position, hasGesture) {
                            if (hasGesture) {
                              _cameraPosition = position.center!;
                              _currentZoom = position.zoom!;
                            }
                          },
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://api.mapbox.com/styles/v1/viet29/clxv8a38d00wc01qm20qzf68u/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidmlldDI5IiwiYSI6ImNseHVqcmFzcTFqcHcyanB0bGd5eHZpbXAifQ.09RsVVUI9mJAcM7lpYasqQ',
                            additionalOptions: const {
                              'accessToken':
                                  'pk.eyJ1IjoidmlldDI5IiwiYSI6ImNseHVqcmFzcTFqcHcyanB0bGd5eHZpbXAifQ.09RsVVUI9mJAcM7lpYasqQ',
                              'id': 'mapbox.mapbox-streets-v8',
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.width20, top: Dimensions.height20),
                  child: SizedBox(
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: locationController.addressTypeList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            locationController.setAddressTypeIndex(index);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width20,
                                vertical: Dimensions.height10),
                            margin: EdgeInsets.only(right: Dimensions.width10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radius20 / 4),
                              color: Theme.of(context).cardColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[200]!,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Icon(
                              index == 0
                                  ? Icons.home_filled
                                  : index == 1
                                      ? Icons.work
                                      : Icons.location_on,
                              color:
                                  locationController.addressTypeIndex == index
                                      ? AppColors.mainColor
                                      : Theme.of(context).disabledColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height20),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Địa chỉ giao hàng"),
                ),
                SizedBox(height: Dimensions.height10),
                AppTextField(
                    textController: _addressController,
                    hintText: "Địa chỉ của bạn",
                    icon: Icons.map),
                SizedBox(height: Dimensions.height20),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Tên"),
                ),
                SizedBox(height: Dimensions.height10),
                AppTextField(
                    textController: _contactPersonName,
                    hintText: "Tên",
                    icon: Icons.person),
                SizedBox(height: Dimensions.height20),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Số điện thoại"),
                ),
                SizedBox(height: Dimensions.height10),
                AppTextField(
                    textController: _contactPersonNumber,
                    hintText: "Số điện thoại",
                    icon: Icons.phone),
              ],
            ),
          );
        });
      }),
      bottomNavigationBar:
          GetBuilder<LocationController>(builder: (locationController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: Dimensions.height20 * 8,
              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  bottom: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      AddressModel _addressModel = AddressModel(
                        addressType: locationController.addressTypeList[
                            locationController.addressTypeIndex],
                        contactPersonName: _contactPersonName.text,
                        contactPersonNumber: _contactPersonNumber.text,
                        address: _addressController.text,
                        latitude:
                            locationController.position.latitude.toString(),
                        longitude:
                            locationController.position.longitude.toString(),
                      );
                      locationController
                          .addAddress(_addressModel)
                          .then((response) {
                        if (response.isSuccess) {
                          Get.back();
                          Get.snackbar(
                              "Địa chỉ", "Cập nhật địa chỉ thành công");
                        } else {
                          Get.snackbar("Địa chỉ", "Không thể cập nhật địa chỉ");
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height10,
                          bottom: Dimensions.height10,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.whiteColor,
                      ),
                      child: BigText(
                        text: "Lưu Địa Chỉ",
                        color: AppColors.blackColor,
                        size: Dimensions.font26 - 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
