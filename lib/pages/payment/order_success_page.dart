import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/base/custom_button.dart';
import 'package:fooddeliveryapp/routes/route_helper.dart';
import 'package:fooddeliveryapp/utils/colors.dart';
import 'package:fooddeliveryapp/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OrderSucessPage extends StatelessWidget {
  final String orderID;
  final int status;

  const OrderSucessPage({Key? key, required this.orderID, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      Future.delayed(Duration(seconds: 1), () {});
    }
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(status==1?Icons.check_circle_outlined:
              Icons.warning_amber_outlined,
              size: 100,color: AppColors.mainColor,),
              SizedBox(
                height: Dimensions.height30,
              ),
              Text(
                status == 1
                    ? 'You placed the order successfully'
                    : 'You order failed',
                style: TextStyle(fontSize: Dimensions.font20),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.height20,
                    vertical: Dimensions.height20),
                child: Text(
                  status == 1 ? 'Successful Order' : 'Failed order',
                  style: TextStyle(
                      fontSize: Dimensions.font20,
                      color: Theme.of(context).disabledColor),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.height20),
                child: CustomButton(
                  buttonText: 'Back To Home',
                  onPressed: () => Get.offAllNamed(RouteHelper.getInitial()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
