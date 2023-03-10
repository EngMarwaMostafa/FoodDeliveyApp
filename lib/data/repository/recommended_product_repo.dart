import 'package:fooddeliveryapp/data/api/api_client.dart';
import 'package:fooddeliveryapp/utils/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async{
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
    //http://mvs.bslmeiyu.com/api/v1/products/popular
  }
}