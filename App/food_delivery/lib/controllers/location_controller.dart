import 'dart:convert';

import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/repository/location_repo.dart';
import '../models/address_model.dart';
import '../models/response_model.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});

  bool _loading = false;
  late Position _position = Position(
    latitude: 0.0,
    longitude: 0.0,
    timestamp: DateTime.now(),
    accuracy: 1.0,
    altitude: 1.0,
    heading: 1.0,
    speed: 1.0,
    speedAccuracy: 1.0,
    altitudeAccuracy: 1.0,
    headingAccuracy: 1.0,
  );
  late Position _pickPosition = _position;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  Placemark get placemark => _placemark;
  Placemark get pickPlacemark => _pickPlacemark;
  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;
  List<AddressModel> get allAddressList => _allAddressList;
  final List<String> _addressTypeList = ["home", "office", "others"];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  late MapController _mapController;
  MapController get mapController => _mapController;

  bool _updateAddressData = true;
  bool _changeAddress = true;

  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;

  // for service zone
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // whether the user is in service zone or not
  bool _inZone = false;
  bool get inZone => _inZone;
  // showing and hiding the button as the map loads
  bool _buttonDisabled = true;
  bool get buttonDisabled => _buttonDisabled;

  // Future<void> getCurrentLocation(bool fromAddress,
  //     {required GoogleMapController mapController,
  //     LatLng? defaultLatLng,
  //     bool notify = true}) async {
  //   _loading = true;
  //   if (notify) {
  //     update();
  //   }
  //   AddressModel _addressModel;
  //   late Position _myPosition;

  //   try {
  //     _myPosition = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.best);
  //     if (fromAddress) {
  //       _position = _myPosition;
  //     } else {
  //       _pickPosition = _myPosition;
  //     }

  //     mapController.animateCamera(CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //           target: LatLng(_myPosition.latitude, _myPosition.longitude),
  //           zoom: 14.0),
  //     ));

  //     Placemark _myPlacemark;
  //     try {
  //       if (!GetPlatform.isWeb) {
  //         List<Placemark> placemarks = await placemarkFromCoordinates(
  //             _myPosition.latitude, _myPosition.longitude);
  //         _myPlacemark = placemarks.first;
  //       } else {
  //         String _address = await getAddressfromGeocode(
  //             LatLng(_myPosition.latitude, _myPosition.longitude));
  //         _myPlacemark = Placemark(
  //             name: _address, locality: '', postalCode: '', country: '');
  //       }
  //     } catch (e) {
  //       String _address = await getAddressfromGeocode(
  //           LatLng(_myPosition.latitude, _myPosition.longitude));
  //       _myPlacemark = Placemark(
  //           name: _address, locality: '', postalCode: '', country: '');
  //     }

  //     fromAddress ? _placemark = _myPlacemark : _pickPlacemark = _myPlacemark;

  //     _addressModel = AddressModel(
  //       latitude: _myPosition.latitude.toString(),
  //       longitude: _myPosition.longitude.toString(),
  //       address:
  //           '${_myPlacemark.name ?? ''} ${_myPlacemark.locality ?? ''} ${_myPlacemark.postalCode ?? ''} ${_myPlacemark.country ?? ''}',
  //       addressType: null,
  //     );

  //     _loading = false;
  //     update();
  //   } catch (e) {
  //     _myPosition = Position(
  //       latitude: defaultLatLng != null ? defaultLatLng.latitude : 0.0,
  //       longitude: defaultLatLng != null ? defaultLatLng.longitude : 0.0,
  //       timestamp: DateTime.now(),
  //       accuracy: 1.0,
  //       altitude: 1.0,
  //       heading: 1.0,
  //       speed: 1.0,
  //       speedAccuracy: 1.0,
  //       altitudeAccuracy: 1.0,
  //       headingAccuracy: 1.0,
  //     );
  //     print("Error: $e");
  //   }
  // }

  void setMapController(MapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(LatLng position, bool fromAddress) async {
    _loading = true;
    update();
    try {
      if (fromAddress) {
        _position = Position(
          latitude: position.latitude,
          longitude: position.longitude,
          timestamp: DateTime.now(),
          heading: 1,
          accuracy: 1,
          altitude: 1,
          speedAccuracy: 1,
          speed: 1,
          altitudeAccuracy: 1,
          headingAccuracy: 1,
        );
      } else {
        _pickPosition = Position(
          latitude: position.latitude,
          longitude: position.longitude,
          timestamp: DateTime.now(),
          heading: 1,
          accuracy: 1,
          altitude: 1,
          speedAccuracy: 1,
          speed: 1,
          altitudeAccuracy: 1,
          headingAccuracy: 1,
        );
      }
      ResponseModel _responseModel = await getZone(
        position.latitude.toString(),
        position.longitude.toString(),
        false,
      );
      _buttonDisabled = !_responseModel.isSuccess;
      if (_changeAddress) {
        String _address = await getAddressfromGeocode(position);
        fromAddress
            ? _placemark = Placemark(name: _address)
            : _pickPlacemark = Placemark(name: _address);
      }
    } catch (e) {
      print(e);
    }
    _loading = false;
    update();
  }

  void updatePickedAddress(LatLng position) async {
  _loading = true;
  update();
  try {
    _pickPosition = Position(
      latitude: position.latitude,
      longitude: position.longitude,
      timestamp: DateTime.now(),
      heading: 1,
      accuracy: 1,
      altitude: 1,
      speedAccuracy: 1,
      speed: 1,
      altitudeAccuracy: 1,
      headingAccuracy: 1,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (placemarks.isNotEmpty) {
      _pickPlacemark = placemarks.first;
    }

    _loading = false;
    update();
  } catch (e) {
    print(e);
    _loading = false;
    update();
  }
}


  Future<String> getAddressfromGeocode(LatLng latlng) async {
    String _address = "Unknown Location Found";
    Response response = await locationRepo.getAddressfromGeocode(latlng);
    if (response.body["status"] == 'OK') {
      _address = response.body["results"][0]['formatted_address'].toString();
      print("Địa chỉ " + _address);
    } else {
      print("Lỗi API");
    }
    update();
    return _address;
  }

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try {
      _addressModel =
          AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch (e) {
      print(e);
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    update();
    Response response = await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await getAddressList();
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
      await saveUserAddress(addressModel);
    } else {
      print("Không thể lưu địa chỉ" + response.statusText!);
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    Response response = await locationRepo.getAllAddress();
    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];
      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
      print("........added........." + _addressList.toString());
    } else {
      _addressList = [];
      _allAddressList = [];
      print(".......not added ........");
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  String getUserAddressFromLocalStorage() {
    return locationRepo.getUserAddress();
  }

  setAddAddressData() {
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    _updateAddressData = false;
    update();
  }

  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async {
    late ResponseModel _responseModel;
    if (markerLoad) {
      _loading = true;
    } else {
      _isLoading = true;
    }
    update();
    Response response = await locationRepo.getZone(lat, lng);
    if (response.statusCode == 200) {
      _inZone = true;
      _responseModel = ResponseModel(true, response.body["zone_id"].toString());
    } else {
      _inZone = false;
      _responseModel = ResponseModel(true, response.statusText!);
    }
    if (markerLoad) {
      _loading = false;
    } else {
      _isLoading = false;
    }
    update();
    return _responseModel;
  }
}
