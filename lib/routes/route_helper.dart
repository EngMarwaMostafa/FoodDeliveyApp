import 'package:fooddeliveryapp/models/order_model.dart';
import 'package:fooddeliveryapp/pages/address/add_address_page.dart';
import 'package:fooddeliveryapp/pages/address/pick_address_mp.dart';
import 'package:fooddeliveryapp/pages/auth/login_page.dart';
import 'package:fooddeliveryapp/pages/cart/cart_page.dart';
import 'package:fooddeliveryapp/pages/food/popular_food_detail.dart';
import 'package:fooddeliveryapp/pages/food/recommended_food_detail.dart';
import 'package:fooddeliveryapp/pages/home/home_pge.dart';
import 'package:fooddeliveryapp/pages/order/order_page.dart';
import 'package:fooddeliveryapp/pages/payment/order_success_page.dart';
import 'package:fooddeliveryapp/pages/payment/payment_page.dart';
import 'package:fooddeliveryapp/pages/splash/splash_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class RouteHelper {
  static const String splashPage = '/splash-page';
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String login = "/login";

  static const String addAddress = '/add-address';
  static const String pickAddressMap = '/pick-address';
  static const String payment = '/payment';
  static const String orderSuccess = '/order_successful';
//  static const String orderPage = '/order_page';

  static String getSplashPage() => '$splashPage';

  static String getRecommendedFood(int pageId, String page) =>
      "$recommendedFood?pageId=$pageId&page=page";

  static String getPopularFood(int pageId, String page) =>
      "$popularFood?pageId=$pageId&page=$page";

  static String getCartPage() => "$cartPage";
  static String getInitial() => "$initial";
  static String getLoginPage() => "$login";
  static String getAddressPage() => '$addAddress';
  static String getPickAddressPage() => '$pickAddressMap';
  static String getPaymentPage(String id,int userID) => '$payment?id=$id&userID=$userID';
  static String getOrderSuccessPage(String orderID,String status) => '$orderSuccess?id=$orderID&status=$status';
//  static String getOrderPage()=>'$orderPage';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(
        name: initial,
        page: () {
          return HomePage();
        },
        transition: Transition.fade),
    GetPage(
      name: login,
      page: () {
        return LoginPage();
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
      name: cartPage,
      page: () {
        return CartPage();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: addAddress,
      page: () {
        return AddAddressPage();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: pickAddressMap,
      page: () {
        PickAddressMap _pickAddressMap = Get.arguments;
        return _pickAddressMap;
      },
    ),
    GetPage(
      name: payment,
      page: () => PaymentPage(
        orderModel: OrderModel(
          id: int.parse(Get.parameters['id']!),
          userId: int.parse(Get.parameters['userID']!),
        ),
      ),
    ),
    GetPage(name: orderSuccess, page: ()=>OrderSucessPage(
      orderID:Get.parameters['id']!,
      status:Get.parameters['status'].toString().contains('success')?1:0,


      )),

  /* GetPage(
      name: orderPage,
      page: () {
        return OrderPage();
      },
      transition: Transition.fade,
    ),*/
  ];
}
