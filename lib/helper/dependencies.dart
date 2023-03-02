import 'package:fooddeliveryapp/controllers/auth_controller.dart';
import 'package:fooddeliveryapp/controllers/cart_controller.dart';
import 'package:fooddeliveryapp/controllers/location_controller.dart';
import 'package:fooddeliveryapp/controllers/order_controller.dart';
import 'package:fooddeliveryapp/controllers/popular-product_controller.dart';
import 'package:fooddeliveryapp/controllers/recommended_product_popular.dart';
import 'package:fooddeliveryapp/controllers/user_controller.dart';
import 'package:fooddeliveryapp/data/api/api_client.dart';
import 'package:fooddeliveryapp/data/repository/auth_repo.dart';
import 'package:fooddeliveryapp/data/repository/cart_repo.dart';
import 'package:fooddeliveryapp/data/repository/location_repo.dart';
import 'package:fooddeliveryapp/data/repository/order_repo.dart';
import 'package:fooddeliveryapp/data/repository/popular_product_repo.dart';
import 'package:fooddeliveryapp/data/repository/recommended_product_repo.dart';
import 'package:fooddeliveryapp/data/repository/user_repo.dart';
import 'package:fooddeliveryapp/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> init()async{
  final sharedPreferences  = await SharedPreferences.getInstance();

    Get.lazyPut(() => sharedPreferences);

  //api client
  Get.lazyPut(()=>ApiClient(appBaseUrl:AppConstants.BASE_URL, sharedPreferences: Get.find()));

  Get.lazyPut(()=>AuthRepo(apiClient:Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(()=>UserRepo(apiClient:Get.find()));
  Get.lazyPut(()=>OrderRepo(apiClient:Get.find()));

 //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient:Get.find(),sharedPreferences:Get.find()));


  //controllers
  Get.lazyPut(()=>AuthController(authRepo:Get.find()));
  Get.lazyPut(()=>UserController(userRepo:Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo:Get.find()));
  Get.lazyPut(() => LocationController(locationRepo:Get.find()));
  Get.lazyPut(() => OdrerController(orderRepo:Get.find()));
}
