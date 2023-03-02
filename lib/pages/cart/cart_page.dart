import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/base/common_text_button.dart';
import 'package:fooddeliveryapp/base/no_data_page.dart';
import 'package:fooddeliveryapp/base/show_custom_snackbar.dart';
import 'package:fooddeliveryapp/controllers/auth_controller.dart';
import 'package:fooddeliveryapp/controllers/cart_controller.dart';
import 'package:fooddeliveryapp/controllers/location_controller.dart';
import 'package:fooddeliveryapp/controllers/order_controller.dart';
import 'package:fooddeliveryapp/controllers/popular-product_controller.dart';
import 'package:fooddeliveryapp/controllers/recommended_product_popular.dart';
import 'package:fooddeliveryapp/controllers/user_controller.dart';
import 'package:fooddeliveryapp/models/place_order_model.dart';
import 'package:fooddeliveryapp/pages/order/delivery_options.dart';
import 'package:fooddeliveryapp/pages/order/payment_option_button.dart';
import 'package:fooddeliveryapp/routes/route_helper.dart';
import 'package:fooddeliveryapp/utils/app_constants.dart';
import 'package:fooddeliveryapp/utils/colors.dart';
import 'package:fooddeliveryapp/utils/dimensions.dart';
import 'package:fooddeliveryapp/widgets/app_icon.dart';
import 'package:fooddeliveryapp/widgets/app_text_field.dart';
import 'package:fooddeliveryapp/widgets/big_text.dart';
import 'package:fooddeliveryapp/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';


class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: Dimensions.height20 * 3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back_ios,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.iconSize24,
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
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.iconSize24,
                  ),
                ],
              )),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItems.length > 0
                ? Positioned(
                    top: Dimensions.height20 * 5,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    bottom: 0,
                    child: Container(
                        margin: EdgeInsets.only(top: Dimensions.height15),
                        // color: Colors.red,
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
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            var popularIndex = Get.find<PopularProductController>().popularProductList
                                                .indexOf(_cartList[index].product);
                                            if (popularIndex >= 0) {
                                              Get.toNamed(RouteHelper.getPopularFood(popularIndex, 'cartpage'));
                                            } else {
                                              var recommendedIndex = Get.find<RecommendedProductController>()
                                                  .recommendedProductList.indexOf(_cartList[index].product);
                                              if (recommendedIndex < 0) {
                                                Get.snackbar(
                                                  'History Product',
                                                  "Product review isn't available for history products",
                                                  backgroundColor:
                                                      AppColors.mainColor,
                                                  colorText: Colors.white,
                                                );
                                              } else {
                                                Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex, "cartpage"));
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: Dimensions.height20 * 5,
                                            height: Dimensions.height20 * 5,
                                            margin: EdgeInsets.only(
                                                bottom: Dimensions.height10),
                                            decoration: BoxDecoration(                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  AppConstants.BASE_URL +
                                                      AppConstants.UPLOAD_URL +
                                                      cartController
                                                          .getItems[index].img!,
                                                ),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(Dimensions.radius20),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimensions.width10,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: Dimensions.height20 * 5,
                                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BigText(
                                                  text: cartController.getItems[index].name!,
                                                  color: Colors.black54,
                                                ),
                                                SmallText(text: "Spicy"),
                                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    BigText(text: cartController.getItems[index].price.toString(),
                                                      color: Colors.redAccent,
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(top: Dimensions.height10,
                                                          bottom: Dimensions.height10,
                                                          left: Dimensions.width10,
                                                          right: Dimensions.width10),
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radius20,
                                                          ),
                                                          color: Colors.white),
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              cartController.addItem(_cartList[index].product!,-1); },
                                                            child: Icon(Icons.remove, color: AppColors.signColor,),
                                                          ),
                                                          SizedBox(width: Dimensions.width10 / 2,),
                                                          BigText(text: _cartList[index].quantity.toString()),
                                                          SizedBox(width: Dimensions.width10 / 2,),
                                                          GestureDetector(
                                                            onTap: () {cartController.addItem(_cartList[index].product!, 1);
                                                              print('being tapped');
                                                            },
                                                            child: Icon(
                                                              Icons.add,
                                                              color: AppColors
                                                                  .signColor,
                                                            ),
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
                                      ],
                                    ),
                                  );
                                });
                          }),
                        )),
                  )
                : NoDataPage(text: 'Your Cart IS Empty');
          })
        ],
      ),
      bottomNavigationBar:GetBuilder<OdrerController>(builder: (orderController){
        _noteController.text=orderController.foodNote;
        return GetBuilder<CartController>(
            builder: (cartController) {
          return Container(
              height: Dimensions.bottomHeightBar + 50,
              padding: EdgeInsets.only(
                  top: Dimensions.height10,
                  bottom: Dimensions.height10,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                ),
              ),
              child: cartController.getItems.length > 0
                  ? Column(
                children: [
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
                                    MediaQuery.of(context).size.height * 0.9,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            Dimensions.radius20),
                                        topRight: Radius.circular(
                                            Dimensions.radius20),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 520,
                                          padding: EdgeInsets.only(
                                            left: Dimensions.width20,
                                            right: Dimensions.width20,
                                            top: Dimensions.height20,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              const PaymentOptionButton(
                                                icon: Icons.money,
                                                subTitle:
                                                'You pay after getting delivery',
                                                index: 0,
                                                title: 'Cash On Delivery',
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10,
                                              ),
                                              const PaymentOptionButton(
                                                icon: Icons.paypal_outlined,
                                                subTitle:
                                                'Safer and faster way of payment',
                                                index: 1,
                                                title: 'Digital Payment',
                                              ),
                                              SizedBox(
                                                height: Dimensions.height30,
                                              ),
                                              Text(
                                                'Delivery Options',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w900,
                                                    fontSize: 25),
                                              ),
                                              DeliveryOptions(
                                                  value: 'delivery',
                                                  title: 'Home Delivery',
                                                  amount: double.parse(
                                                      Get.find<CartController>().totalAmount
                                                          .toString()),
                                                  isFree: false),
                                              SizedBox(
                                                height:
                                                Dimensions.height10 / 2,
                                              ),
                                              const DeliveryOptions(
                                                  value: 'Take Away',
                                                  title: 'Take Away',
                                                  amount: 10,
                                                  isFree: true),
                                              SizedBox(
                                                height: Dimensions.height20,
                                              ),
                                              Text(
                                                'Additional Notes',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w900,
                                                    fontSize: 25),
                                              ),
                                              AppTextField(textController: _noteController,
                                                hintText: '',
                                                icon: Icons.note,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).whenComplete(() => orderController.setFoodNote(_noteController.text.trim())),
                    child: const SizedBox(
                      width: double.maxFinite,
                      child: CommonTextButton(
                        text: 'Payment Options',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height20,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: Dimensions.width10 / 2,),
                            BigText(text: "\$" + cartController.totalAmount.toString()),
                            SizedBox(width: Dimensions.width10 / 2,),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (Get.find<AuthController>().userLoggedIn()) {
                            if (Get.find<LocationController>().addressList.isEmpty) {
                              Get.toNamed(RouteHelper.getAddressPage());
                            } else {
                              // Get.offNamed(RouteHelper.getInitial());
                              // Get.offNamed(RouteHelper.getPaymentPage('20', Get.find<UserController>().userModel!.id));
                              var location = Get.find<LocationController>().getUserAddress();
                              var cart = Get.find<CartController>().getItems;
                              var user = Get.find<UserController>().userModel;
                              PlaceOrderBody placeOrder = PlaceOrderBody(
                                cart: cart,
                                orderAmount: 100.0,
                                orderNote: orderController.foodNote,
                                distance: 10.0,
                                address: location.address,
                                latitude: location.latitude,
                                longitude: location.longitude,
                                contactPersonName: user!.name,
                                contactPersonNumber: user.phone,
                                paymentMethod: orderController.paymentIndex==0?'cash_on_delivery':'digital_payment',
                                orderType: orderController.orderType,
                              );
                           //   print('My type is'+placeOrder.toJson()['order_type']);
                           Get.find<OdrerController>().
                           placeOrder(placeOrder, _callback);
                            }
                          } else {
                            Get.toNamed(RouteHelper.getLoginPage());
                          }
                        },
                        child: CommonTextButton(
                          text: 'Check Out',
                        ),
                      ),
                    ],
                  ),
                ],
              )
                  : Container());
        });
      }),

    );
  }
}

void _callback(bool isSucess, String message, String orderID) {
  if (isSucess) {
    Get.find<CartController>().clear();
    Get.find<CartController>().removeCartSharedPrefrences();
    Get.find<CartController>().addToHistory();

    if(Get.find<OdrerController>().paymentIndex==0){
       Get.offNamed(RouteHelper.getOrderSuccessPage(orderID, 'success'));
    }else{
      Get.offNamed(RouteHelper.getPaymentPage(orderID, Get.find<UserController>().userModel!.id));
    }

  } else {
    showCustomSnackbar(message);
  }
}
