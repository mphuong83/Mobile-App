import 'package:flutter/material.dart';
import 'package:food_delivery/app/colors.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }
  // tang giam so luong dat hang

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      //print("tang so luong: " +  _quantity.toString());
      _quantity = checkQuantity(_quantity + 1);
      //print("number of items "+_quantity.toString());
    } else {
      //print("giam so luong: " + _quantity.toString());
      _quantity = checkQuantity(_quantity - 1);
      //print("decrement "+_quantity.toString());
    }
    update();
  }

  // _inCartItems =2;
  // _quantity =0;
  //_quantity = -2;
  // thong bao vuot qua so luong dat hang
  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        "Số lượng mặt hàng",
        "Bạn không thể giảm số lượng mặt hàng!",
        backgroundColor: AppColors.redColor,
        colorText: Colors.white,
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar(
        "Số lượng mặt hàng",
        "Bạn không thể thêm số lượng mặt hàng!",
        backgroundColor: AppColors.redColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  // khoi tao so luong dat hang la 0
  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    // if exist in storage

    //get from storage _inCartItems = 0;
    //print("exist or not "+exist.toString());
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    //print("the quantity in the cart is "+_inCartItems.toString());
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print("The id is " +
          value.id.toString() +
          " The quantity: " +
          value.quantity.toString());
    });

    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
