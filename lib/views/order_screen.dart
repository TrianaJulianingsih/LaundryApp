import 'package:flutter/material.dart';
import 'package:laundry_app/api/order.dart';
import 'package:laundry_app/models/register_model.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  // final bool? appBar;
  static const id = "/orderScreen";

  @override
  State<OrderScreen> createState() => _TugasTujuhState();
}

class _TugasTujuhState extends State<OrderScreen> {
  GetProfile? orders;
  String? errorMessage;
  bool isLoading = false;

  void handleOrder()async{
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    // final layanan = 

    // try{
    //   final result = await AuthenticationAPI.addOrder(layanan: layanan, service: service, item: item, metodePembayaran: metodePembayaran, totalItem: totalItem, harga: harga)
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 86,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Color(0xFF03A9F4),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 1),
                        child: Text(
                          "Pesananku",
                          style: TextStyle(
                            fontFamily: "Montserrat_Bold",
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // DropdownButton(items: ["Kiloan", "Satuan", "VIP", "Sepatu", "Setrika", "Express"], onChanged: onChanged)
        ],
      ),
    );
  }
}
