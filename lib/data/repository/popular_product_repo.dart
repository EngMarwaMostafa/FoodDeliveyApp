import 'package:fooddeliveryapp/data/api/api_client.dart';
import 'package:fooddeliveryapp/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService{
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async{
   return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
   //http://mvs.bslmeiyu.com/api/v1/products/popular

  }

}