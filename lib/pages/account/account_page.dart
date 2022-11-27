import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/base/custom_app_bar.dart';
import 'package:fooddeliveryapp/base/custom_loader.dart';
import 'package:fooddeliveryapp/controllers/auth_controller.dart';
import 'package:fooddeliveryapp/controllers/cart_controller.dart';
import 'package:fooddeliveryapp/controllers/location_controller.dart';
import 'package:fooddeliveryapp/controllers/user_controller.dart';
import 'package:fooddeliveryapp/routes/route_helper.dart';
import 'package:fooddeliveryapp/utils/colors.dart';
import 'package:fooddeliveryapp/utils/dimensions.dart';
import 'package:fooddeliveryapp/widgets/account_widget.dart';
import 'package:fooddeliveryapp/widgets/app_icon.dart';
import 'package:fooddeliveryapp/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      // print('User has Logged in')
    }

    return Scaffold(
        appBar: CustomAppBar(title: 'Profile',),
        body:
        /*GetBuilder<UserController>(
          builder: (userController) {
            return _userLoggedIn
                ? (userController.isLoading
                    ?*/
            Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: Dimensions.height20),
                        child: Column(
                          children: [
                            //profile icon
                            AppIcon(
                              icon: Icons.person,
                              backgroundColor: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconSize:
                                  Dimensions.height45 + Dimensions.height30,
                              size: Dimensions.height15 * 10,
                            ),
                            SizedBox(
                              height: Dimensions.height30,
                            ),
                            //name
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.person,
                                        backgroundColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: 'Marwa',
                                        // text:userController.userModel.name
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //phone
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.phone,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: '1111111111',
                                        //     tex:userController.userModel.phone
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //email
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.email,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: 'abc@gmail.com',
                                        //userController.userModel.email
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //address
                                    GetBuilder<LocationController>(
                                        builder: (locationController) {
                                          if(_userLoggedIn&&locationController.addressList.isEmpty){
                                            return GestureDetector(
                                              onTap: (){
                                                Get.offNamed(RouteHelper.getAddressPage());
                                              },
                                              child: AccountWidget(
                                                appIcon: AppIcon(
                                                  icon: Icons.location_on,
                                                  backgroundColor: AppColors.yellowColor,
                                                  iconColor: Colors.white,
                                                  iconSize: Dimensions.height10 * 5 / 2,
                                                  size: Dimensions.height10 * 5,
                                                ),
                                                bigText: BigText(
                                                  text: 'Fill in your address',
                                                ),
                                              ),
                                            );
                                          }else{
                                          return  GestureDetector(
                                              onTap: (){
                                                Get.offNamed(RouteHelper.getAddressPage());
                                              },
                                              child: AccountWidget(
                                                appIcon: AppIcon(
                                                  icon: Icons.location_on,
                                                  backgroundColor: AppColors.yellowColor,
                                                  iconColor: Colors.white,
                                                  iconSize: Dimensions.height10 * 5 / 2,
                                                  size: Dimensions.height10 * 5,
                                                ),
                                                bigText: BigText(
                                                  text: 'Your address',
                                                ),
                                              ),
                                            );
                                          }
                                        }),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                   if (Get.find<AuthController>()
                                            .userLoggedIn()) {
                                          Get.find<AuthController>()
                                              .clearSharedData();
                                          Get.offNamed(
                                              RouteHelper.getLoginPage());
                                          Get.find<CartController>().clear;
                                          Get.find<CartController>()
                                              .clearCartHistory();
                                        } else {
                                          print('you logged out');
                                        }
                                      },
                                      child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.message_outlined,
                                          backgroundColor: Colors.redAccent,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                          text: 'Messages',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.logout,
                                        backgroundColor: Colors.redAccent,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: 'LogOut',
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                  //  : CustomLoader())
             //   : Container(

                /*    child:
                         Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: Dimensions.width20 * 20,
                            margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20,
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage('assets/images/bike.png'))),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getLoginPage());
                            },
                            child: Container(
                              width: double.maxFinite,
                              height: Dimensions.width20 * 5,
                              margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                              ),
                              child: Center(
                                child: BigText(
                                  text: 'Log in',
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),*/
                  );
      //    },
     //   ));
  }
}
