import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery/app/app_constants.dart';
import 'package:food_delivery/app/colors.dart';
import 'package:food_delivery/app/dimensions.dart';
import 'package:food_delivery/app/styles.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/widgets/BigText.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  final OrderModel orderModel;
  PaymentPage({required this.orderModel});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedBank;
  String accountNumber = '';
  String accountName = '';
  String amount = '';
  String transferContent = '';
  String searchQuery = '';
  final TextEditingController _bankController = TextEditingController();

  List<Map<String, String>> banks = [
    {'name': 'MBBank (MB)', 'fullName': 'Ngân hàng Quân đội', 'logo': 'assets/images/Icon-MB-Bank-MBB.webp'},
    {'name': 'Vietinbank (CTG)', 'fullName': 'Ngân hàng Công Thương Việt Nam', 'logo': 'assets/images/vietiin.webp'},
    {'name': 'BIDV', 'fullName': 'Ngân hàng Đầu tư và Phát triển Việt Nam', 'logo': 'assets/images/bidv.webp'},
    {'name': 'Agribank (VBA)', 'fullName': 'Ngân hàng Nông nghiệp và Phát triển nông thôn Việt Nam', 'logo': 'assets/images/agribank.webp'},
    {'name': 'Vietcombank (VCB)', 'fullName': 'Ngân hàng Ngoại thương Việt Nam', 'logo': 'assets/images/Icon-Vietcombank.png'},
    {'name': 'VPBank (VPB)', 'fullName': 'Ngân hàng Việt Nam Thịnh Vượng', 'logo': 'assets/images/Icon-VPBank.png'},
    {'name': 'VIB', 'fullName': 'Ngân hàng Quốc tế Việt Nam', 'logo': 'assets/images/vib.png'},
    {'name': 'SHB', 'fullName': 'Ngân hàng Sài Gòn - Hà Nội', 'logo': 'assets/images/Icon-SHB.webp'},
    {'name': 'Eximbank (EIB)', 'fullName': 'Ngân hàng Xuất Nhập Khẩu Việt Nam', 'logo': 'assets/images/exim.webp'},
    {'name': 'TPBank (TPB)', 'fullName': 'Ngân hàng Tiên Phong', 'logo': 'assets/images/Icon-TPBank.webp'},
    {'name': 'Cake by VP', 'fullName': 'Ngân hàng số Cake by VPBank', 'logo': 'assets/images/cake.webp'},
  ];

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      print("Form is valid");
      print("Selected Bank: $selectedBank");
      print("Account Number: $accountNumber");
      print("Account Name: $accountName");
    } else {
      print("Form is not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: BigText(
          text: "Thanh toán",
          color: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.mainColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
          ),
          onPressed: () {
            Get.toNamed(RouteHelper.getCartPage());
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(text: "Nhập thông tin"),
                SizedBox(height: 20),
                TextFormField(
                  controller: _bankController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Ngân hàng',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: AppColors.mainColor, width: 2.0),
                    ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (BuildContext context, StateSetter setState) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(Dimensions.radius20),
                                  topRight: Radius.circular(Dimensions.radius20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: Dimensions.height10,
                                      horizontal: Dimensions.width20,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        BigText(text: "Chọn ngân hàng"),
                                        SizedBox(height: 10),
                                        TextField(
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.search),
                                            hintText: 'Tìm theo tên ngân hàng',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8.0),
                                              borderSide: BorderSide(color: AppColors.mainColor, width: 2.0),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              searchQuery = value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: banks.length,
                                      itemBuilder: (context, index) {
                                        if (searchQuery.isNotEmpty && !banks[index]['name']!.toLowerCase().contains(searchQuery.toLowerCase())) {
                                          return Container();
                                        }
                                        return ListTile(
                                          onTap: () {
                                            setState(() {
                                              selectedBank = banks[index]['name'];
                                              _bankController.text = banks[index]['name']!;
                                            });
                                            Navigator.pop(context);
                                          },
                                          title: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radius20 / 4),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey[200]!,
                                                  blurRadius: 5,
                                                  spreadRadius: 1,
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: Dimensions.height10,
                                                horizontal: Dimensions.width10,
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        banks[index]['logo']!,
                                                        width: 40,
                                                        height: 40,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      SizedBox(width: Dimensions.width10),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              banks[index]['name']!,
                                                              style: robotoBold.copyWith(fontSize: Dimensions.font16),
                                                            ),
                                                            Text(
                                                              banks[index]['fullName']!,
                                                              style: robotoRegular.copyWith(fontSize: Dimensions.font12, color: Colors.grey),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  validator: (value) {
                    if (selectedBank == null) {
                      return 'Vui lòng chọn ngân hàng';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Số tài khoản',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: AppColors.mainColor, width: 2.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      accountNumber = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập số tài khoản';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Tên tài khoản',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: AppColors.mainColor, width: 2.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      accountName = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên tài khoản';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle form submission here
                        Get.offNamed(RouteHelper.getOrderSuccessPage(
                            widget.orderModel.id.toString(), 'success'));
                      }
                    },
                    child: Text('Thanh Toán',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor,
                      padding:
                      EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
