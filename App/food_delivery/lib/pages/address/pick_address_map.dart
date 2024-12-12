import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:food_delivery/app/colors.dart';
import 'package:food_delivery/widgets/BigText.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart'; // Import LatLng from latlong2
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import '../../controllers/location_controller.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final MapController? mapController;

  const PickAddressMap({
    Key? key,
    required this.fromSignup,
    required this.fromAddress,
    this.mapController,
  }) : super(key: key);

  @override
  _PickAddressMapState createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late MapController _mapController;
  LatLng? _pickedPosition;
  String? _pickedAddress;

  @override
  void initState() {
    super.initState();
    _mapController = widget.mapController ?? MapController();
    final locationController = Get.find<LocationController>();
    _initialPosition = LatLng(
      locationController.position.latitude,
      locationController.position.longitude,
    );
    _pickedPosition = _initialPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(
          text: "Cập nhật địa chỉ",
          color: Colors.white,
        ),
        backgroundColor: AppColors.mainColor,
        elevation: 0,
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      body: OpenStreetMapSearchAndPick(
        buttonColor: AppColors.mainColor,
        buttonText: 'Cập nhật địa chỉ',
        onPicked: (pickedData) async {
          final locationController = Get.find<LocationController>();
          LatLng pickedLatLng = LatLng(
            pickedData.latLong.latitude,
            pickedData.latLong.longitude,
          );
          locationController.updatePosition(
            pickedLatLng,
            true, // Assuming this is from address
          );
          Navigator.of(context).pop(pickedData.address.toString());
        },
      ),
    );
  }
}
