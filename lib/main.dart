import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/controllers/auth_controller.dart';
import 'package:fooddeliveryapp/controllers/cart_controller.dart';
import 'package:fooddeliveryapp/controllers/location_controller.dart';
import 'package:fooddeliveryapp/controllers/popular-product_controller.dart';
import 'package:fooddeliveryapp/controllers/recommended_product_popular.dart';
import 'package:fooddeliveryapp/pages/address/add_address_page.dart';
import 'package:fooddeliveryapp/pages/cart/cart_page.dart';
import 'package:fooddeliveryapp/pages/food/recommended_food_detail.dart';
import 'package:fooddeliveryapp/pages/home/food_page_body.dart';
import 'package:fooddeliveryapp/pages/home/main_food_page.dart';
import 'package:fooddeliveryapp/pages/splash/splash_page.dart';
import 'package:fooddeliveryapp/routes/route_helper.dart';
import 'package:fooddeliveryapp/utils/colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'helper/dependencies.dart' as dep;

 Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
           primaryColor: AppColors.mainColor,
            fontFamily: 'Lato',
          ),
          //  home:AddAddressPage(),
      initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );
    });
    });
  }
}


